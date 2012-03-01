class AddProjectIdToWorkDocuments < ActiveRecord::Migration
  def change
    add_column :work_documents, :template_id, :integer

  end
end
