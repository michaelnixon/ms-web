class PagesController < ApplicationController
  def main
    @categories = Category.all
    @items = Item.all.order("RANDOM()")
  end

  def about
  end

  def contact
  end
end
