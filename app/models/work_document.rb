class WorkDocument < ActiveRecord::Base
	validates :project, :presence => true

	has_one :document, :as => :documentable, :dependent => :destroy

	accepts_nested_attributes_for :document

	belongs_to :project
end
