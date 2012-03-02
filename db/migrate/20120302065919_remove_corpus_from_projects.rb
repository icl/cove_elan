class RemoveCorpusFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :corpus_id
      end

  def down
    add_column :projects, :corpus_id, :string
  end
end
