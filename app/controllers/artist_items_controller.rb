class ArtistItemsController < ApplicationController
  def index
    @artist = Artist.find(params[:id])
    @items = @artist.items
  end

  def new
    @artist = Artist.find(params[:id])
  end

  def create
    @artist = Artist.find(params[:id])
    item = @artist.items.create(artist_item_params)
    redirect_to "/artists/#{@artist.id}/items"
  end

  private
  def artist_item_params
    params.permit(:name, :rating, :price, :stock, :num_sold, :free_shipping, :artist_id)
  end
end
