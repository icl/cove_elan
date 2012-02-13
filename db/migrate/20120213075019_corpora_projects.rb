class CorporaProjects < ActiveRecord::Migration
  def up
    create_table :corpora_projects do |t|
      t.belongs_to :corpus
      t.belongs_to :project
    end
  end

  def down
  end
end
