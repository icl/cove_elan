class AddNameToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :name, :string

  end
end
