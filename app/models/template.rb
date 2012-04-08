require 'interval_tree'

class Template < ActiveRecord::Base
  validates :user, :presence => true

	has_many :work_documents
  has_many :project_templates
  has_many :projects, :through => :project_templates

 	has_many :meta_data_values, :as => :meta_data_valuable, :dependent => :destroy

	has_many :meta_data_group_assignments, :as => :meta_data_group_assignable
	has_many :meta_data_groups, :through => :meta_data_group_assignments


	belongs_to :document, :dependent => :destroy
	belongs_to :user

  accepts_nested_attributes_for :meta_data_groups

  def name_or_id
    return self.name.nil? ? 'Template ' + self.id.to_s : self.name
  end

  def annotations_by_tier
    tier_annotations = {}

    #Build a hash of a tier, with annotations and time slots for each document under the template
    self.document.tiers.each do |tier|
      document_annotations = {}

      self.work_documents.each do |wd|
        wd.document.tier_annotations(tier).each do |annotation|
          if document_annotations[annotation[:annotation_value]] then
            document_annotations[annotation[:annotation_value]].push(  [annotation[:ts_ref1], annotation[:ts_ref2]]  )
          else
            ts_array = [ annotation[:ts_ref1], annotation[:ts_ref2] ]
            document_annotations[annotation[:annotation_value]] = [ts_array]
          end
       end
      end

      tier_annotations[tier[:tier_id]] = document_annotations
    end

    return tier_annotations
  end

  #Remove any annotations with duplicate start and end time slots
	def get_unique_permutations annotation_time_slot
		return annotation_time_slot.uniq.permutation.to_a
	end

  def overlapping_annotations
    tier_annotations = annotations_by_tier

    #Now we can find all permutations per annotation and hunt for duplicates like a beagle hunts for wabbits.
    tier_overlap_slots = {}
    tier_annotations.each do |tier, annotation|
      tier_overlap_slots[tier] = {}

      annotation.each do |value, ts_array|
				overlap_slots = Array.new
				intervals = Array.new
				unique = ts_array.uniq

				#Build ranges for each unique interval
				unique.each do |u|
					intervals.push( (u[0]...u[1]) )
				end

				#Build our interval tree
				i_tree = IntervalTree::Tree.new(intervals)
				
				unique.each do |u|
					interval = (u[0]...u[1])
					search_result = i_tree.search(interval)
					if search_result[0] != interval and search_result.length > 0 then
						overlap_slots.push([ u, [search_result[0].begin, search_result[1].end]])
					end
				end
				tier_overlap_slots[tier][value] = overlap_slots
    	end
 	 	end

		return tier_overlap_slots
	end
end
