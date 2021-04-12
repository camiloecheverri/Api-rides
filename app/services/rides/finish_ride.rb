require_relative "./update_ride_amount"
require_relative "./make_payment"
require_relative "./update_payment_status"
#
# Class FinishRide provides a service wich finishes a ride (includes payment actions)
# @Params
# driver_identification - string - personal identification for driver
# longitude - number - finish longitude where ride ends (in km)
# latitude - number - finish latitude where ride ends (in km)
# @Returns
# [Success - boolean, ride_finished - Ride instance | error - string]
# @author Camilo Echeverri - camilo98423@hotmail.com
#
class FinishRide
  def call(driver_identification, longitude, latitude)
    driver = Driver.find_by(identification: driver_identification)
    current_ride = driver.rides.where(status: 'in_progress').first
    UpdateRideAmount.new.call(current_ride, [latitude, longitude])
    success, payment_status = current_ride.payment_in_progress? ?
                              UpdatePaymentStatus.new.call(current_ride.payments.last) :
                              MakePayment.new.call(current_ride)
    unless success
      return [false, 'We apologize but the payment was rejected, please try again']
    end
    driver.avaible!
    current_ride.rider.avaible!
    [ current_ride.finish!, current_ride ]
  end
end
