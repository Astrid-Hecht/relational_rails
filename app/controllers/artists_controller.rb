class ArtistsController < ApplicationController
  def index
    @artists = Artist.recent
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
  end

  def create
    artist = Artist.create!(artist_params)
    redirect_to "/artists"
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    artist = Artist.find(params[:id])
    artist.update(artist_params)
    redirect_to '/artists'
  end

  def destroy
    artist = Artist.find(params[:id])
    artist.destroy
    redirect_to '/artists'
  end

private
  def artist_params
    params.permit(:username, :location, :followers, :accepts_returns)
  end
end
