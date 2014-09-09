class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  layout 'admin'    
  def show
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end  
end
