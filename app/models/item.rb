class Item < ActiveRecord::Base
  include Bootsy::Container
  mount_uploader :image, ImageUploader
  has_many :attachments, :as => :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  has_and_belongs_to_many :categories
  validates :name, presence: true
  validates :preview, presence: true
  
  # create a many to many bi-directional association with Items through a join table
  has_many :connections, :foreign_key => "item_id", :class_name => "Connection"
  has_many :connecteds, :through => :connections 

  def connect(item)
    unless self.connecteds.include? item
      self.connecteds << item
      item.connecteds << self
    end
  end
  
  def short_name
    name.truncate(50)
  end
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
    
  def largest_version
    if image_large_height.nil? or image_thumb_height.nil?
      return :empty
    elsif image_large_height > image_thumb_height
      return :large
    else
      return :thumb
    end
  end
  
  def landscape?
    unless image_large_width.nil? or image_large_height.nil?
      if image_large_width > image_large_height
        return true
      else
        return false
      end
    else
      return false
    end
  end
  # uses SQL like to determine if the name or preview text matches the search term
  # TODO fix promoted false issue
  def self.search(search)
    if search
#      includes(:categories, :attachments).where("(name like ? OR preview like ?) AND categories IS NOT NULL", "%#{search}%", "%#{search}%")
      joins(:categories).where("(name like ? OR preview like ?)", "%#{search}%").distinct
    else
      joins(:categories).distinct
    end
  end

end
