class AddStateToWorkDocuments < ActiveRecord::Migration
  def change
    add_column :work_documents, :state, :string

  end
end
