class RemoveProjectNameFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :project_name
      end

  def down
    add_column :projects, :project_name, :string
  end
end
