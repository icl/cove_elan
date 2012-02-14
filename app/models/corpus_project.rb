class CorpusProject < ActiveRecord::Base
  self.table_name = 'corpora_projects'
  validates :corpus, :project, :presence => 'true'

  belongs_to :corpus
  belongs_to :project
end
