class AddBannerSizesToAssets < ActiveRecord::Migration
  def change
    add_column :items, :image_banner_height, :integer
    add_column :items, :image_banner_width, :integer    
  end
end
