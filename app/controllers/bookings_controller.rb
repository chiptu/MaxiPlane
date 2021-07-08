class BookingsController < ApplicationController

  def new
    if !user_signed_in?
      redirect_to new_user_session_path and return
    else
      @flight = Vol.find(params[:flight_id])
      if @flight.nbSeatsEco > 0
        if @flight.nbSeatsPremium > 0
          @option_select_class = [['Eco', 1], ['Premium', 2]]
        else
          @option_select_class = [['Eco', 1]]
        end
      else
        if @flight.nbSeatsPremium > 0
          @option_select_class = [['Premium', 2]]
        else
          @option_select_class = []
        end
      end

    end
  end

  def index
    if !user_signed_in?
      redirect_to new_user_session_path and return
    else
      @reservations = Registration.where(user_id: current_user.id)
    end
  end

  def create
    @flight = Vol.find(params[:vol_id])
    if params[:classe] == '1'
      message="Erreur il manque des places dans la classe que vous avez choisi"
      if @flight.nbSeatsEco - params[:nbPlace].to_i >=0
        @reservation = Registration.create(
          classe: 'Eco',
          nbPlace: params[:nbPlace],
          codeConfirmation: SecureRandom.hex(6),
          vol_id: params[:vol_id],
          user_id: current_user.id
        )
        BookingMailer.with(user: current_user, booking: @reservation).booking_email.deliver_now
        @flight.nbSeatsEco -= params[:nbPlace].to_i
        @flight.save
        message="La réservation a bien été enregistré"
      end
    elsif params[:classe] == '2'
      if @flight.nbSeatsPremium - params[:nbPlace].to_i >= 0
        @reservation = Registration.create(
          classe: 'Premium',
          nbPlace: params[:nbPlace],
          codeConfirmation: SecureRandom.hex(6),
          vol_id: params[:vol_id],
          user_id: current_user.id
        )
        BookingMailer.with(user: current_user, booking: @reservation).booking_email.deliver_now
        @flight.nbSeatsPremium -= params[:nbPlace].to_i
        @flight.save
        message="La réservation a bien été enregistré"
      end
      else
        message="Erreur il manque des places dans la classe que vous avez choisi"
    end
    redirect_to flights_path , :alert =>message
  end

  def show
    @reservation = Registration.find(params[:id])
    @flight = Vol.find(@reservation.vol_id)
  end

  def destroy
    @flight = Vol.find(params[:flight_id])
    @reservation = Registration.find(params[:id])
    if @reservation.classe == 'Eco'
      @flight.nbSeatsEco += @reservation.nbPlace
      @flight.save
      @reservation.delete
      redirect_to bookings_path
    else
      @flight.nbSeatsPremium += @reservation.nbPlace
      @flight.save
      @reservation.delete
      redirect_to bookings_path
    end
  end
end
