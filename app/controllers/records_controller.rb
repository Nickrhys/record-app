class RecordsController < ApplicationController

  def index
    @records = Record.all
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.create(record_params)
    @record.tracks.build
    redirect_to records_path
  end

  def show
    @record = Record.find(params[:id])
    @artist = @record.artist
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    @record.update(record_params)
    redirect_to record_path(@record)
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    flash[:notice] = 'Record deleted successfully'
    redirect_to records_path
  end

  protected

  def record_params
    params.require(:record).permit(:name, :artist_id)
  end
end
