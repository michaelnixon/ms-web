class Connection < ActiveRecord::Base
  belongs_to :item, :foreign_key => "item_id", :class_name => "Item"
  belongs_to :connected, :foreign_key => "connected_id", :class_name => "Item"  
end