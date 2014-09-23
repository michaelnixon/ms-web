# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  after :remove, :delete_empty_upstream_dirs
  
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{base_store_dir}/#{model.id}"
  end
  
  def base_store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/"
  end
  
  #to avoid keeping some empty folders once an image has been removed, these commands take care of removing those storage folders
  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir

    path = ::File.expand_path(base_store_dir, root)
    Dir.delete(path) # fails if path not empty dir
  rescue SystemCallError
    true # nothing, the dir is not empty
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  VERY_BIG_STUPID_NUMBER_THIS_IS_IMAGE_MAGICK_I_HATE_IT = 1000
  HEIGHT_OF_PREVIEW_ITEMS = 200
  HEIGHT_OF_FOCUS_ITEMS = 380
  
  version :large do
    process :resize_to_limit => [VERY_BIG_STUPID_NUMBER_THIS_IS_IMAGE_MAGICK_I_HATE_IT, HEIGHT_OF_FOCUS_ITEMS]
    process :store_dimensions    
  end
      
  # thumbnails are used on preview page; this code fixes them to be max 200 height and then whatever width is possible, maintaining scale
  version :thumb do
    process :resize_to_fill => [HEIGHT_OF_PREVIEW_ITEMS, HEIGHT_OF_PREVIEW_ITEMS]
    process :store_dimensions    
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  
  private
    def store_dimensions
      if file && model
        model.send("image_#{version_name.to_s}_width=", ::MiniMagick::Image.open(file.path)[:dimensions][0]) 
        model.send("image_#{version_name.to_s}_height=", ::MiniMagick::Image.open(file.path)[:dimensions][1])
      end
    end
end
