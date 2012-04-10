require 'find'

class Capture < ActiveRecord::Base

  
  has_many :user_assets
  belongs_to :user


  def acquire_contents
    if File.directory? self.path
      sub_paths = Find.find(self.path)
                      .reject {|path| File.directory? path }
      sub_paths.each do |sub_path|
        create_asset(file_name: File.open(sub_path))
      end
    else
      create_asset(file_name: File.open(path))
    end
  end

  def create_asset(attributes={})
    self.user_assets << UserAsset.create(attributes)
  end

end
