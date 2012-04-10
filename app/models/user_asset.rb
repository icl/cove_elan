require 'carrierwave/orm/activerecord'

class UserAsset < ActiveRecord::Base
  validates :file_name, :presence => true
  belongs_to :user
  belongs_to :capture

  mount_uploader :file_name, UserAssetUploader

  def asset_type
    type_info =  %x[file --mime -b #{file_name.path} ]
    type_info.split(';')[0].split('/')[0]
  end
end
