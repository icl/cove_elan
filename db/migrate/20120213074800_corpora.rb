class Corpora < ActiveRecord::Migration
  def up
    create_table :corpora do |t|
      t.column :name, :string, :null => false
      t.column :description, :text
    end
	
	create_table :work_documents do |t|
	  t.timestamps
    t.belongs_to :user
		t.belongs_to :project
	end

	create_table :documents do |t|
		t.string :eaf
		t.references :documentable, :polymorphic => true
		t.belongs_to :annotation_document
		t.timestamps
	end
	
	create_table :projects do |t|
	  t.timestamps
	  t.column :project_name, :string, :null => false
	  t.column :description, :text, :null => false

    t.belongs_to :user
    t.belongs_to :corpus
	end
  end

  def down
  end
end
