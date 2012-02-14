    class DocumentProject < ActiveRecord::Base

      belongs_to :document
      belongs_to :project
    end