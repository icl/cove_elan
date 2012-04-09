class Capture < ActiveRecord::Base
  has_many :user_assets
  belongs_to :user
end
