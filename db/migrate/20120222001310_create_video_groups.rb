class CreateVideoGroups < ActiveRecord::Migration
  def up
	create_table :video_groups do |t|
		t.belongs_to :document
		t.belongs_to :corpus
	end
  end

  def down
  end
end
