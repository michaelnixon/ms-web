class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_filter :logged_in?
  layout 'admin'  
  # GET /items
  # GET /items.json
  def index
    @items = Item.all.order("name ASC") #.sort_by {|i| i.send "category.name" rescue ""}
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @categories = Category.find_all_nested
    @connectable_items = Item.all
  end

  # GET /items/1/edit
  def edit  
    @categories = Category.find_all_nested
    @connectable_items = Item.all
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @categories = Category.find_all_nested
    respond_to do |format|
      if @item.save
        # add
        format.html { redirect_to admin_items_url, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: [:admin,@item] }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    @categories = Category.find_all_nested
    respond_to do |format|
      if @item.update(item_params)
        # add
        format.html { redirect_to admin_items_url, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin,@item] }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to admin_items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :body, :preview, :bootsy_image_gallery_id, :image, :featured, :remove_image, attachments_attributes: [:description, :file, :_destroy, :id], :connected_ids => [], :category_ids => [])
    end
end
