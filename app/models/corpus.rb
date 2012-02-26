class Corpus < ActiveRecord::Base
	validates :name, :description, :presence => 'true'
  validate :document_media_is_unique, :on => :fuck

  has_many :projects

	has_many :documents, :as => :documentable, :dependent => :destroy

	accepts_nested_attributes_for :documents

  def document_media_is_unique
  puts "HERE"
   corpus_media   = Array.new
   document_media = Array.new

   self.documents.each { |d| d.media_descriptors.each { |m| corpus_media.push(m[:media_url]) } }
   self.documents.last.media_descriptors.each { |m| document_media.push(m[:media_url]) }

   leftover_media = (corpus_media | document_media) - (corpus_media & document_media)

   #errors.add :wtf, "SUCKS" if leftover_media.empty?
   errors.add :wtf, "MOO"

  end
end
