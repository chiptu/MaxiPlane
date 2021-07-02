class CreateVols < ActiveRecord::Migration[6.1]
  def change
    create_table :vols do |t|
      t.datetime :departureDate
      t.integer :duration
      t.string :arrivalAirport
      t.string :departureAirport
      t.integer :nbSeatsEco
      t.integer :nbSeatsPremium
      t.integer :number

      t.timestamps
    end
  end
end
