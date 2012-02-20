class RemoveFileNameFromDocument < ActiveRecord::Migration
  def up
    remove_column :documents, :file_name
      end

  def down
    add_column :documents, :file_name, :string
  end
end
