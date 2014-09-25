class DropPromotedFromItems < ActiveRecord::Migration
  def change
    remove_column(:items, :promoted)    
  end
end
