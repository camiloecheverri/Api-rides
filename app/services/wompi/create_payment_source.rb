require 'typhoeus'
require 'json'

require_relative './get_acceptance_token'
require_relative '../../models/rider'
require_relative '../../models/payment_source'
#
# Class CreatePaymentSource provides a service wich make payment for ride
# @Params
# rider_identification - string - personal rider identification
# @Returns
# [Success - boolean, payment_source - PaymentSource instance | parse_response - request response]
# @author Camilo Echeverri - camilo98423@hotmail.com
#
class CreatePaymentSource
  WOMPI_TEST_URL = "https://sandbox.wompi.co/v1"
  PUBLIC_WOMPI_KEY = "prv_test_v5WExE5NCi6x0RLWII2lXXoWsJ38OzfB"

  def call(rider_identification, card_tokenization)
    rider = Rider.find_by(identification: rider_identification)
    success, acceptance_token = GetAcceptanceToken.new.call()
    headers = {'Content-Type' => 'application/json',
               'Accept'=>'application/json',
               'Authorization' => "Bearer #{PUBLIC_WOMPI_KEY}"
              }
    body = {
      type: "CARD",
      token: card_tokenization,
      customer_email: rider.email,
      acceptance_token: acceptance_token
    }
    response = Typhoeus.post("#{WOMPI_TEST_URL}/payment_sources", body: body.to_json, headers: headers)
    parse_response = JSON.parse(response.body)
    data = parse_response["data"]
    if response.success?
      new_payment_source = PaymentSource.new({type: "CARD", token: data["id"], card_token: card_tokenization})
      rider.payment_source = new_payment_source
      rider.save!
      [true, new_payment_source]
    else
      [false, parse_response]
    end
  end
end
