require 'typhoeus'
class GetAcceptanceToken
  WOMPI_TEST_URL = "https://sandbox.wompi.co/v1"
  PUBLIC_WOMPI_KEY = "pub_test_6aDNMjZ6sCJ6GvtWN9pKx1O1RxshbsQy"
  #
  # Class MakePayment provides a service wich get acceptance_token
  # @Params
  #  -
  # @Returns
  # [Success - boolean, acceptance_token - string]
  # @author Camilo Echeverri - camilo98423@hotmail.com
  #
  def call
    headers = {'Content-Type' => 'application/json',
               'Accept'=>'application/json',
              }
    response = Typhoeus.get("#{WOMPI_TEST_URL}/merchants/#{PUBLIC_WOMPI_KEY}", headers: headers)
    data = JSON.parse(response.body)["data"]
    if response.success?
      [true, data["presigned_acceptance"]["acceptance_token"]]
    end
  end
end
