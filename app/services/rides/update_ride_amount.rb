require 'geocoder'
#
# Class UpdateRideAmount provides a service wich calculate ride's amount to be pay in cents
# @Params
# current_ride - Ride instance
# finish_longitude - number - finish longitude where ride ends (in km)
# finish latitude - number - finish latitude where ride ends (in km)
# @Returns
# amoun_in_cents - number
# @author Camilo Echeverri - camilo98423@hotmail.com
#
class UpdateRideAmount
  BASE_FEE = 3500

  def call(current_ride, finish_location)
    distance = Geocoder::Calculations.distance_between(current_ride.start_location, finish_location, units: :km)
    ends_at = Time.now
    time_elapsed = ((ends_at - current_ride.starts_at) / 60).to_i
    amount = (BASE_FEE + (distance*1000) + (time_elapsed*200)).to_i
    update_params = {
      ends_at: ends_at,
      amount_in_cents: amount*100,
      finish_location: finish_location
    }
    current_ride.update!(update_params)
  end
end
