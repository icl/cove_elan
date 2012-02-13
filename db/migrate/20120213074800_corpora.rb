class Corpora < ActiveRecord::Migration
  def up
    create_table :corpora do |t|
      t.column :name, :string, :null => false
      t.column :description, :text
    end
  end

  def down
  end
end
