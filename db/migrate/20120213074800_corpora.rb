class Corpora < ActiveRecord::Migration
  def up
    create_table :corpora do |t|
      t.column :name, :string, :null => false
      t.column :description, :text
    end
	
	create_table :documents do |t|
	  t.timestamps

	  t.column :file_name, :string, :null => false
    t.belongs_to :user
	end

  create_table :document_projects do |t|
    t.belongs_to :document
    t.belongs_to :project
  end
	
	create_table :projects do |t|
	  t.timestamps
	  t.column :project_name, :string, :null => false
	  t.column :description, :text, :null => false

    t.belongs_to :user
	end
  end

  def down
  end
end
