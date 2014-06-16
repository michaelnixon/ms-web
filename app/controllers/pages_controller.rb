class PagesController < ApplicationController
  def main
    @categories = Category.all
    @items = Item.all.shuffle
  end

  def about
  end

  def contact
  end
end
