require_relative "../../models/ride"
require_relative "../../models/rider"
require_relative "../../models/driver"
#
# Class CreateNewRide provides a service wich creates a ride
# @Params
# rider_identification - string - personal identification for rider
# longitude - number - current longitude where ride'll start (in km)
# latitude - number current latitude where ride'll start (in km)
# @Returns
# [Success - boolean, ride_created - Ride instance]
# @author Camilo Echeverri - camilo98423@hotmail.com
#
class CreateNewRide
  def call(rider_identification, longitude, latitude)
    rider = Rider.find_by(identification: rider_identification)
    driver = Driver.where(status: 'free').first
    ride_params = {
      rider_id: rider.id,
      driver_id: driver.id,
      starts_at: Time.now,
      start_location: [latitude, longitude],
    }
    new_ride = Ride.create!(ride_params)
    rider.in_ride!
    driver.in_ride!
    [ new_ride.persisted?, new_ride ]
  end
end
