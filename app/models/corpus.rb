class Corpus < ActiveRecord::Base
	validates :name, :description, :presence => 'true'

  has_many :projects
end
