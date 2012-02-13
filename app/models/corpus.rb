class Corpus < ActiveRecord::Base
  validates :id, :presence => 'true'
  has_many :corpus_projects
  has_many :projects, :through => :corpus_projects
end
