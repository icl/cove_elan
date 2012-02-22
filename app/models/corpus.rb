class Corpus < ActiveRecord::Base
	validates :name, :description, :presence => 'true'

  has_many :projects
	has_one :video_group
end
