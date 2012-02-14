class Corpus < ActiveRecord::Base
  has_many :corpus_projects
  has_many :projects, :through => :corpus_projects
end
