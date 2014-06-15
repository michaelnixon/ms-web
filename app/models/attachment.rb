class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  
  mount_uploader :file, MediaFileUploader
  
  def is_video_file?
    file.content_type == "application/mp4"
  end
end
