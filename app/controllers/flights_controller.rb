class FlightsController < ApplicationController

  def index

    @flights = Vol.where('departureDate >= ?', DateTime.now)
  end

  def show
    @flight = Vol.find(params[:id])
  end

end


