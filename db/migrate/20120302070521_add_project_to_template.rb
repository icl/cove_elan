class AddProjectToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :project_template_id, :integer

  end
end
