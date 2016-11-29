class RecordsController < ApplicationController

  before_filter :load_record, only: [:show, :edit, :update, :destroy]

  def index
    @records = Record.all
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.create(record_params)
    @record.save!
    redirect_to new_record_track_path(@record)
  end

  def show
  end

  def edit
  end

  def update
    @record.update(record_params)
    redirect_to record_path(@record)
  end

  def destroy
    @record.destroy
    flash[:notice] = 'Record deleted successfully'
    redirect_to records_path
  end

  protected

  def load_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:name, :artist_id, :avatar)
  end
end
