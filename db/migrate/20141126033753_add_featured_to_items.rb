class AddFeaturedToItems < ActiveRecord::Migration
  def change
    add_column :items, :featured, :boolean
  end
end
