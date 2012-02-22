class VideoGroup < ActiveRecord::Base
	belongs_to :document
	belongs_to :corpus
end
