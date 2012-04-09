require 'carrierwave/orm/activerecord'

class UserAsset < ActiveRecord::Base
  validates :file_name, :presence => true
  belongs_to :user
  belongs_to :capture

  mount_uploader :file_name, UserAssetUploader
end
