class ItemsController < ApplicationController
  def index
    @items = Item.true_select
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to "/items/#{item.id}"
  end

  private
  def item_params
    params.permit(:name, :rating, :price, :stock, :num_sold, :free_shipping)
  end
end
