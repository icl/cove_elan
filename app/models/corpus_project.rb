require 'elan_parser_db_model'

class CorpusProject < ActiveRecord::Base
  self.table_name = 'corpora_projects'
  validates :corpus, :project, :presence => 'true'

  belongs_to :corpus
  belongs_to :project, :class_name => "ElanParser::DB::Project"
end
