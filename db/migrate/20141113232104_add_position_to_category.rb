class AddPositionToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :position, :integer, :default => 100
  end
end
