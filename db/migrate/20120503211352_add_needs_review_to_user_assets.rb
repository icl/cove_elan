class AddNeedsReviewToUserAssets < ActiveRecord::Migration
  def change
    add_column :user_assets, :needs_review, :boolean, :null => false, :default => true
    add_column :templates, :needs_review, :boolean, :null => false, :default => true
  end
end
