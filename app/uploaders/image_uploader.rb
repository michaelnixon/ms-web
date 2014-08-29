# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
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
  very_big_stupid_number_this_is_image_magick_i_hate_it = 1000000
  # Create different versions of your uploaded files:
  version :portrait, :if => :is_portrait? do
    process :resize_to_limit => [very_big_stupid_number_this_is_image_magick_i_hate_it, 400]
  end
  
  version :landscape, :if => :is_landscape? do
    process :resize_to_limit => [400, very_big_stupid_number_this_is_image_magick_i_hate_it]
  end
   
  version :square, :if => :is_square? do
    process :resize_to_limit => [400, 400]
  end
      
  version :thumb do
    process :resize_to_fill => [200, 200]
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
  
  protected
  
    def is_square? picture
      begin
        image = MiniMagick::Image.open(picture.path)
        return image[:width] == image[:height]      
      rescue => e
        Rails.logger.warn "Unable to determine whether image is square, probably missing: #{e}" 
      end
    end
    
    def is_landscape? picture
      begin
        image = MiniMagick::Image.open(picture.path)
        return image[:width] > image[:height]
      rescue => e
        Rails.logger.warn "Unable to determine whether image is landscape, probably missing: #{e}" 
      end      
    end
    
    def is_portrait? picture
      begin
        image = MiniMagick::Image.open(picture.path)
        return image[:width] < image[:height]
      rescue => e
        Rails.logger.warn "Unable to determine whether image is portrait, probably missing: #{e}" 
      end        
    end

end
