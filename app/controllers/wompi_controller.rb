require_relative '../services/wompi/create_payment_source'
require_relative "../contracts/wompi/create_payment_source_contract"
class WompiController < BaseController
  put '/payment-source' do
    contract = CreatePaymentSourceContract.new
    errors = contract.call(@request_payload).errors.to_h
    halt 400, errors.to_json if errors.any?
    success, payload = CreatePaymentSource.new.call(@request_payload['identification'], @request_payload['card_tokenization'])
    halt 400, payload.to_json unless success
    { payment_source: payload }.to_json if success
  end
end
