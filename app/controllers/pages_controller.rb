class PagesController < ApplicationController
  def main
    @categories = Category.find_all_top_level
    @promoted_items = Item.all.select {|i| i.categories.empty? }
    @banner_items = Item.all.where(featured: true)
    #Item.where(category_id: nil).order("name")
    @sub_categories = []
    @items = Item.search(params[:search]).reject {|i| i.categories.empty?}.shuffle
  end
  
  def change_focus
    @item = Item.find(params[:id])
    respond_to do |format|
      format.js
    end    
  end
  
  def change_subnav
      @banner_items = Item.all.where(featured: true)
    if params[:id]
      @category = Category.find_by_id(params[:id])
      @sub_categories = @category.categories.order(position: :asc, name: :asc)
    else
      @category = nil
      @sub_categories = []
    end
    respond_to do |format|
      format.js
    end
  end
  
end
