class Category < ActiveRecord::Base
  has_many :items
  belongs_to :category
  has_many :categories
  validates :name, presence: true
  
  def pretty_name
    if category
      return "-- #{name}"
    else
      return name
    end
  end
  
  def top_level?
    category.nil?
  end
  
  def self.find_all_top_level
    Category.where('category' => nil).order("name")
  end
  
  def self.find_all_children id
    Category.where('category_id' => id).order("name")
  end
  
  def self.find_all_nested
    cats = []
    all_cats = Category.find_all_top_level
    all_cats.each do |cat|
      cats << cat
      Category.find_all_children(cat.id).each do |subcat|
        cats << subcat
      end
    end
    return cats
  end
end
