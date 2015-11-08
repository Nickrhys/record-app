class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
  end
  
  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.create(artist_params)
    redirect_to "/records/new"
  end

  protected

  def artist_params
    params.require(:artist).permit(:name)
  end
end