class Corpus < ActiveRecord::Base
	validates :name, :description, :presence => 'true'

  has_many :projects
	has_many :video_groups
end
