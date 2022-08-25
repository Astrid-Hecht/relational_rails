class ArtistItemsController < ApplicationController
  def index
    @artist = Artist.find(params[:artist_id])
    @items = @artist.items
  end
end
