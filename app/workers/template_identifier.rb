class TemplateIdentifer 
  @queue = :elan

  def self.perform(work_document_id)
    work_document.process!
    work_document = WorkDocument.find(work_document_id)
    work_document.template_identify
    work_document.finish!
  end
end
