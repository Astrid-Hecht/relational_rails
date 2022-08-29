class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.permit(:name, :rating, :price, :stock, :num_sold, :free_shipping)
  end
end
