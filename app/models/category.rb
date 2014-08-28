class Category < ActiveRecord::Base
  has_many :items
  belongs_to :category
  has_many :categories
  validates :name, presence: true
  
  
  def top_level?
    category.nil?
  end
  
  def self.find_all_top_level
    Category.where('category' => nil)
  end
end
