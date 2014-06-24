class PagesController < ApplicationController
  def main
    @categories = Category.all.order("name")
    @items = Item.search(params[:search]).shuffle
  end

  def about
  end

  def contact
  end
end
