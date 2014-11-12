class CreateJoinTableItemCategory < ActiveRecord::Migration
  def change
    create_join_table :items, :categories
    Item.all.each do |i|
      if i.category
        i.categories << i.category
      end
    end
  end
end
