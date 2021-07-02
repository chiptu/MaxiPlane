# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require 'csv'

CSV.foreach(Rails.root.join('lib/seed_csv/flights.csv'), headers: true) do |row|
  Vol.create( {
                  number: row['number'],
                  departureAirport: row['departure_airport'],
                  arrivalAirport: row['arrival_airport'],
                  nbSeatsPremium: row['business_class_seats'].to_i,
                  nbSeatsEco: row['economy_class_seats'].to_i,
                  departureDate: row['departure_date'].to_datetime,
                  duration: row['duration'].to_i,
                } )
end

User.create! username: 'test', email: 'test@test.com', password: 'topsecret', password_confirmation: 'topsecret'
