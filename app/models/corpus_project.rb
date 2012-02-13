require 'elan_parser_db_model'

class CorpusProject < ActiveRecord::Base
  belongs_to :corpus
  belongs_to :project, :class_name => "ElanParser::DB::Project"
end
