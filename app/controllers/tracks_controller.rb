class TracksController < ApplicationController

  def new
    @record = Record.find(params[:record_id])
    @tracks = @record.tracks
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    respond_to do |format|
      if @track.save
        format.html { redirect_to @track, notice: 'Track was successfully created.' }
        format.js
        format.json { render json: @track, status: :created, location: @track }
      else
        format.html { render action: "new" }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @track.update(track_params)
  end

  def destroy
    @track.destroy
    flash[:notice] = 'Track deleted successfully'
  end

  protected

  def track_params
    params.require(:track).permit(:name, :record_id)
  end
end
