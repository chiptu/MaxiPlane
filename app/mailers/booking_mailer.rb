class BookingMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def booking_email
    @user = params[:user]
    @booking = params[:booking]
    @vol = Vol.find(@booking.vol_id)
    mail(to: @user.email, subject: 'Flight reservation confirmation '+@booking.codeConfirmation )
  end
end
