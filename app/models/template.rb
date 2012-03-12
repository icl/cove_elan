class Template < ActiveRecord::Base
  validates :user, :presence => true

	has_many :work_documents
  has_many :project_templates
  has_many :projects, :through => :project_templates

 	has_many :meta_data_values, :as => :meta_data_valuable, :dependent => :destroy
  has_one :meta_data_group, :as => :meta_data_groupable


	belongs_to :document, :dependent => :destroy
	belongs_to :user

  accepts_nested_attributes_for :meta_data_group

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
  def remove_duplicate_annotations annotation_time_slots
    #Find duplicates within the array, and mark them before creating permutations of them
    annotation_time_slots.each do |ts, ts_array|
      if ts_array.uniq.count == 1
        annotation_time_slots.delete(ts)
      end
    end

    return annotation_time_slots
  end

  def overlapping_annotations
    tier_annotations = annotations_by_tier

    #Now we can find all permutations per annotation and hunt for duplicates like a beagle hunts for wabbits.
    tier_overlap_slots = {}
    tier_annotations.each do |tier, annotation|
      tier_overlap_slots[tier] = {}

      #Find duplicates within the array, and mark them before creating permutations of them
      remove_duplicate_annotations annotation

      annotation.each do |value, ts_array|
        annotation_permutations = ts_array.permutation
        overlap_slots = Array.new

        annotation_permutations.each_with_index do |p, index|

          p.each do |x|
            num_1 = x[0]
            num_2 = x[1]
            #Compare with the next value, otherwise compare with the first value
            if p[index+1] then
              second_1 = p[index+1][0]
              second_2 = p[index+1][1]
            else
              second_1 = p[0][0]
              second_2 = p[0][1]
            end

            #Test for overlap so long as each permutation is unique
            overlap = ( (num_1 - second_2) * (second_1 - num_2) > 0) unless (num_1 == second_1 && num_2 == second_2)

            if overlap then
               overlap_slots.push([ [num_1, num_2], [second_1, second_2] ]) \
                unless overlap_slots.include?([ [num_1, num_2], [second_1, second_2] ]) \
                  or overlap_slots.include?([ [second_1, second_2], [num_1, num_2] ])
            end
          end

          tier_overlap_slots[tier][value] = overlap_slots

        end
      end
    end

    return tier_overlap_slots
  end
end
