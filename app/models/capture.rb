class Capture < ActiveRecord::Base

  has_many :user_assets
  belongs_to :user

  @@authorized_paths = []

  def self.authorize_path(path)
    @@authorized_paths << [path]
  end

  def self.authorized_paths
    @@authorized_paths
  end
  validates_inclusion_of( :path, :in => ->(p){ Capture.authorized_paths  })


  end
