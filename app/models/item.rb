class Item < ActiveRecord::Base
  include Bootsy::Container
  mount_uploader :image, ImageUploader
  has_many :attachments, :as => :attachable
  belongs_to :shape
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  belongs_to :category
  validates :name, presence: true
  validates :preview, presence: true

  def to_param
    [id, name.parameterize].join("-")
  end
      
  # checks if various resized versions exists to provide the preview geometry
  def preview_geometry
    if landscape?
      the_image = MiniMagick::Image.open(image.versions[:landscape].path)    
    elsif portrait?
      the_image = MiniMagick::Image.open(image.versions[:portrait].path)
    elsif square?
      the_image = MiniMagick::Image.open(image.versions[:square].path)
    else
      # default image handling goes here or an error will occur
      return "200x200"
    end
    "#{the_image['width']}x#{the_image['height']}"
  end
  
  def thumb_geometry
    if image
      the_image = MiniMagick::Image.open(image.versions[:thumb].path)  
      return "#{the_image['width']}x#{the_image['height']}"
    else 
      return nil
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
  
  # checks if various resized versions exists to provide the url to them 
  def preview_url
    if landscape?
      image_url(:landscape)
    elsif portrait?
      image_url(:portrait)
    elsif square?
      image_url(:square)
    else
      # default image handling goes here or an error will occur upon loading
      "http://placehold.it/200x200"
    end
  end
  
  def landscape?
    image.version_exists? :landscape
  end
  
  def portrait?
    image.version_exists? :portrait
  end
  
  def square?
    image.version_exists? :square
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
