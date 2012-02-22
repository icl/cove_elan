require 'carrierwave/orm/activerecord'

class Document < ActiveRecord::Base
      validates :project, :eaf, :presence => true
      validate :annotation_document_is_valid, :on => :create

      belongs_to :user
      belongs_to :project
      belongs_to :annotation_document, :class_name => "ElanParser::DB::AnnotationDocument"
	
			has_one :video_group

      mount_uploader :eaf, EafUploader

      def base_name
        File.basename file_name, '.eaf'
      end

      def create_annotation_document
        eaf_document = self.eaf.file.read
        @annotation_document = ElanParser::XML::Save.new(eaf_document, File.basename(self.eaf.to_s))
        self.annotation_document_id = @annotation_document.pkey_id
      end

			#The document is a gateway into the Elan Structure. Build some helper methods.
			def media_descriptors
				media_descriptors = Array.new

				self.annotation_document.header.media_descriptors.each do |media_descriptor|
					media_descriptors.push(
						:id => media_descriptor.id,
						:media_url => media_descriptor.media_url,
						:relative_media_url => media_descriptor.relative_media_url,
						:mime_type => media_descriptor.mime_type,
						:time_origin => media_descriptor.time_origin,
						:extracted_from => media_descriptor.extracted_from
					)
				end

				return media_descriptors
			end

			def tiers
				tiers = Array.new

				self.annotation_document.tiers.each do |tier|
					tiers.push(
						:id => tier.id,
						:tier_id => tier.tier_id,
						:participant => tier.participant,
						:annotator   => tier.annotator,
						:linguistic_type_ref => tier.linguistic_type_ref,
						:default_locale => tier.default_locale,
						:parent_ref => tier.parent_ref
						)
				end

				return tiers
			end

			def annotations
				annotations = Array.new

				self.annotation_document.tiers.each do |tier|
					tier.annotations.each do |annotation|
						ts1 = annotation.alignable_annotation.alignable_annotation_time_slot.time_slot_ref1.time_value
						ts2 = annotation.alignable_annotation.alignable_annotation_time_slot.time_slot_ref2.time_value
						annotations.push(
							:annotation_value => annotation.alignable_annotation.annotation_value,
							:ts_ref1 => ts1,
							:ts_ref2 => ts2
						)
					end
				end

				return annotations
			end

      private
      def annotation_document_is_valid
        unless @annotation_document.nil?
          @annotation_document.validation_errors.each do |xsd_error|
            errors.add :xsd_validation, xsd_error.to_s
          end
        end
      end
end
