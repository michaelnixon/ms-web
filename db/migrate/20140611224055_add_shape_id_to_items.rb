class AddShapeIdToItems < ActiveRecord::Migration
  def change
    add_reference :items, :shape, index: true
  end
end
