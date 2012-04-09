class CreateCaptures < ActiveRecord::Migration
  def change
    create_table :captures do |t|
      t.text :path
      t.string :name
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end
end
