class AddDocumentToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :document_id, :integer

  end
end
