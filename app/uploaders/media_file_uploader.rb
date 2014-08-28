# encoding: utf-8

class MediaFileUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(pdf doc docx mp4 png webm ogg mp3 jpg jpeg gif avi wmv xaml mov aif mpg mpeg flv swf)
  end

end
