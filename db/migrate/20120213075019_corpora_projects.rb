class CorporaProjects < ActiveRecord::Migration
  def up
    create_table :corpora_projects do |t|
      t.belongs_to :corpora
      t.belongs_to :projects
    end
  end

  def down
  end
end
