class CreateTemplates < ActiveRecord::Migration
  def up
		create_table "templates" do |t|
			t.timestamps
		end
  end

  def down
  end
end
