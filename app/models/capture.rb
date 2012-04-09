class Capture < ActiveRecord::Base

  validates_inclusion_of( :path, :in => ->(p){ Capture.authorized_paths  })
  
  has_many :user_assets
  belongs_to :user

  @@authorized_paths = []

  def self.authorize_path(path)
    @@authorized_paths << path
  end

  def self.authorized_paths
    @@authorized_paths
  end

  def self.authorized_paths=(paths)
    @@authorized_paths = paths
  end


  end
