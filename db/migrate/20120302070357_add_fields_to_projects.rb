class AddFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :name, :string

    add_column :projects, :project_template_id, :integer

  end
end
