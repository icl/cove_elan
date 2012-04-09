require 'carrierwave/orm/activerecord'

class UserAsset < ActiveRecord::Base
  validates :file_name, :presence => true
  belongs_to :user

  mount_uploader :file_name, UserAssetUploader
end
