class AddConnectionsJoinTable < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :item_id
      t.integer :connected_id
    end    
  end
end
