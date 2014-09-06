class PagesController < ApplicationController
  def main
    @categories = Category.find_all_top_level
    @promoted_items = Item.where(promoted: true).order("name")
    @sub_categories = []
    @items = Item.search(params[:search]).shuffle
  end

  def about
  end
  
  def change_subnav
    if params[:id]
      @category = Category.find_by_id(params[:id])
      @sub_categories = @category.categories
    else
      @category = nil
      @sub_categories = []
    end
    respond_to do |format|
      format.js
    end
  end
  
end
