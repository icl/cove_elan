require 'carrierwave/orm/activerecord'

class UserAsset < ActiveRecord::Base
  validates :file_name, :presence => true
  belongs_to :user
  belongs_to :capture

  has_many :user_asset_assignments

  has_many :templates, :through => :user_asset_assignments, :source => :user_asset_assignable, :source_type => 'Template'

  has_many :meta_data_group_assignments, :as => :meta_data_group_assignable
  has_many :meta_data_groups, :through => :meta_data_group_assignments

  has_many :meta_data_values, :as => :meta_data_valuable

  mount_uploader :file_name, UserAssetUploader

  def asset_type
    type_info =  %x[file --mime -b #{file_name.path} ]
    type_info.split(';')[0].split('/')[0]
  end

  def self.match_basename(basename)
    where(["file_name like ?", "%#{basename}"  ])
  end

end
