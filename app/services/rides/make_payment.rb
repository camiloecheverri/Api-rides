require 'typhoeus'
require 'json'

require_relative '../../models/payment'
require_relative './update_payment_status'
#
# Class MakePayment provides a service wich make payment for ride
# @Params
# current_ride - Ride instance - ride to be paid
# @Returns
# [Success - boolean, paymet_status - string]
# @author Camilo Echeverri - camilo98423@hotmail.com
#
class MakePayment
  WOMPI_TEST_URL = "https://sandbox.wompi.co/v1"
  BASE_REFERENCE = "sJT5987dDjkd9985np"
  PUBLIC_WOMPI_KEY = "prv_test_v5WExE5NCi6x0RLWII2lXXoWsJ38OzfB"
  def call(current_ride)
    body = {
      amount_in_cents: current_ride.amount_in_cents,
      currency: "COP",
      customer_email: current_ride.rider.email,
      payment_method: {
        installments: 1
      },
      reference: "#{BASE_REFERENCE}#{Payment.all.count}",
      payment_source_id: current_ride.rider.payment_source.token
    }
    headers = {'Content-Type' => 'application/json',
               'Accept'=>'application/json',
               'Authorization' => "Bearer #{PUBLIC_WOMPI_KEY}"
              }
    response = Typhoeus.post("#{WOMPI_TEST_URL}/transactions", body: body.to_json, headers: headers)
    data = JSON.parse(response.body)["data"]
    if response.success?
      payment = Payment.create!(reference_id: data["id"], ride_id: current_ride.id)
      UpdatePaymentStatus.new.call(payment)
      [payment.approved?, payment.status]
    end
  end
end
