class RecordsController < ApplicationController

  def index
    @records = Record.all
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.create(record_params)
    redirect_to records_path
  end


  protected

  def record_params
    params.require(:record).permit(:name)
  end
end
