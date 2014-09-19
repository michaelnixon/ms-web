class AddImageMetaColumns < ActiveRecord::Migration
  def change
    add_column :items, :image_thumb_height, :string
    add_column :items, :image_thumb_width, :string    
    add_column :items, :image_large_height, :string    
    add_column :items, :image_large_width, :string        
  end
end
