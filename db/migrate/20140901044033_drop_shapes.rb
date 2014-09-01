class DropShapes < ActiveRecord::Migration
  def change
    drop_table :shapes
    remove_column(:items, :shape_id)
  end
end
