class Welcome < ActiveRecord::Base
	has_many :documents, :as => :documentable, :dependent => :destroy

	accepts_nested_attributes_for :documents
end
