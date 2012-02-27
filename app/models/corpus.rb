class Corpus < ActiveRecord::Base
	validates :name, :description, :presence => 'true'
  validate :document_media_is_unique

  has_many :projects

	has_many :documents, :as => :documentable, :dependent => :destroy

	accepts_nested_attributes_for :documents

  private
  #Validate that all document media is unique
  def document_media_is_unique
   return if self.documents.count == 0

   valid = true

   corpus_media   = Array.new

   self.documents.each { |d| corpus_media.push(:id => d.id, :media => d.media_descriptors) }

   last_media_urls = Array.new
   last = self.documents.last
   last.media_descriptors.each { |m| last_media_urls.push(m[:media_url]) }

   corpus_media.each do |m|
    if m[:id] != last.id then
      item_media_urls = Array.new
      m[:media].each { |m| item_media_urls.push(m[:media_url]) }

      if (last_media_urls == item_media_urls)
        valid = false
        break
      end
    end
   end

      errors.add :file, "contains a media set already in this corpus." if valid == false
  end
end
