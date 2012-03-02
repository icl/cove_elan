class CreateProjectTemplates < ActiveRecord::Migration
  def change
    create_table :project_templates do |t|
      t.integer :project_id
      t.integer :template_id

      t.timestamps
    end
  end
end
