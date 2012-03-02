class Template < ActiveRecord::Base
	has_many :work_documents

	belongs_to :document
end
