class FlightsController < ApplicationController

  def index

    @flights = Vol.all
  end

  def show
    @flight = Vol.find(params[:id])
  end

end


