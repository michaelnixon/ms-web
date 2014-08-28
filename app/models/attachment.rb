class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  
  mount_uploader :file, MediaFileUploader
  VIDEO_EXTENSIONS = ["mp4", "webm", "ogg", "mp3", "avi", "wmv", "xaml", "mov", "aif", "mpg", "mpeg", "flv", "swf", "quicktime"]
  IMAGE_EXTENSIONS = ["jpg", "jpeg", "png", "gif"]
  DOC_EXTENSIONS = ["pdf", "doc", "docx"]
  
  def is_video_file?
    VIDEO_EXTENSIONS.any?{ |o| file.content_type =~ /\b#{Regexp.escape(o)}\b/ }
  end
  
  def is_image_file?
    IMAGE_EXTENSIONS.any?{ |o| file.content_type =~ /\b#{Regexp.escape(o)}\b/ }    
  end
  
  def is_doc_file?
    DOC_EXTENSIONS.any?{ |o| file.content_type =~ /\b#{Regexp.escape(o)}\b/ }    
  end
  
end
