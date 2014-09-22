class ChangeImageMetaTypesToInteger < ActiveRecord::Migration
  def change
    change_column :items, :image_thumb_height, :integer
    change_column :items, :image_thumb_width, :integer    
    change_column :items, :image_large_height, :integer    
    change_column :items, :image_large_width, :integer    
  end
end
