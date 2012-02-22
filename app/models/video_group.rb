class VideoGroup < ActiveRecord::Base
	belongs_to :document
	belongs_to :corpus


	def media_descriptors
		return self.document.media_descriptors
	end
end
