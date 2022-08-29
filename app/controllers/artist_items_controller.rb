class ArtistItemsController < ApplicationController
  def index
    @artist = Artist.find(params[:artist_id])
    @items = @artist.items
  end

  def new
  end

  def create
    artist_item = Artist.item.create(item_params)
    redirect_to "/artists"
  end
end
