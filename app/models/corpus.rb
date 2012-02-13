class Corpus < ActiveRecord::Base
 has_many :corpora_projects
 has_many :projects, :through => "corpora_projects", :class_name => "ElanParser::DB::Project"
end
