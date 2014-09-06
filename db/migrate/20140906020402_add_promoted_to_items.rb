class AddPromotedToItems < ActiveRecord::Migration
  def change
    add_column :items, :promoted, :boolean, :default => false
  end
end
