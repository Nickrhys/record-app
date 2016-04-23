class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
  end
  
  def new
    @artist = Artist.new
  end

  def show
  end

  def create
    @artist = Artist.create(artist_params)
    redirect_to "/records/new"
  end

  def records
    @artist = Artist.find(params[:id])
    @records = @artist.records.all
  end

  protected

  def artist_params
    params.require(:artist).permit(:id, :name)
  end
end