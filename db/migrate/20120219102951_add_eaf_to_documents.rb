class AddEafToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :eaf, :string

  end
end
