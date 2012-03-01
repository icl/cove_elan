class RemoveProjectIdFromWorkDocuments < ActiveRecord::Migration
  def up
    remove_column :work_documents, :project_id
      end

  def down
    add_column :work_documents, :project_id, :integer
  end
end
