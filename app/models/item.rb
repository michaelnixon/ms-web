class Item < ActiveRecord::Base
  include Bootsy::Container
  mount_uploader :image, ImageUploader
  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  belongs_to :category
  validates :name, presence: true
  validates :preview, presence: true
  
  # provide a slightly nicer url for referencing individual items
  def to_param
    [id, name.parameterize].join("-")
  end
      
  def thumb_geometry
    if image and image.version_exists? :thumb    
      return "#{image_thumb_width}x#{image_thumb_height}"
    else 
      return ""
    end
  end
  
  def video_attachments
    attachments.select {|a| a.is_video_file? }
  end
  
  def doc_attachments
    attachments.select {|a| a.is_doc_file? }    
  end
  
  def image_attachments
    attachments.select {|a| a.is_image_file? }    
  end
    
  def landscape?
    if image and image.version_exists? :large
      image_large_width > image_large_height
    else
      return false
    end
  end
  # uses SQL like to determine if the name or preview text matches the search term
  def self.search(search)
    if search
      includes(:category, :attachments).where("name like ? or preview like ? and promoted = ?", "%#{search}%", "%#{search}%", false)
#      includes(:category, :attachments).where("name like ? or preview like ?", "%#{search}%", "%#{search}%")
    else
      includes(:category, :attachments).where("promoted = ?", false)
    end
  end

end
