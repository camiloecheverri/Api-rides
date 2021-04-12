require 'typhoeus'
require 'json'

require_relative '../../models/payment'
#
# Class UpdatePaymentStatus provides a service wich update status of a payment
# @Params
# payment - Payment instance - Payment to be updated
# @Returns
# [Success - boolean, paymet_status - string]
# @author Camilo Echeverri - camilo98423@hotmail.com
#
class UpdatePaymentStatus
  WOMPI_TEST_URL = "https://sandbox.wompi.co/v1"
  PUBLIC_WOMPI_KEY = "prv_test_v5WExE5NCi6x0RLWII2lXXoWsJ38OzfB"
  def call(payment)
    headers = {'Content-Type' => 'application/json',
               'Accept'=>'application/json',
               'Authorization' => "Bearer #{PUBLIC_WOMPI_KEY}"
              }
    response = Typhoeus.get("#{WOMPI_TEST_URL}/transactions/#{payment.reference_id}", headers: headers)
    data = JSON.parse(response.body)["data"]
    if response.success?
      case data["status"]
      when "APPROVED"
        payment.bill!
      when "DECLINED"
        payment.decline!
      when "VOIDED"
        payment.void!
      when "ERROR"
        payment.error!
      end
      [payment.approved?, payment.status]
    end
  end
end
