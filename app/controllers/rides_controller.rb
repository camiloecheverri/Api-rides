require 'sinatra'
# services
require_relative "../services/rides/create_new_ride"
require_relative "../services/rides/finish_ride"
require_relative "../contracts/rides/new_ride_contract"
require_relative "../contracts/rides/finish_ride_contract"

before do
  request.body.rewind
  @request_payload = JSON.parse request.body.read
end

post '/ride' do
  contract = NewRideContract.new
  errors = contract.call(@request_payload).errors.to_h
  halt 400, errors.to_json if errors.any?
  success, payload = CreateNewRide.new.call(@request_payload['identification'], @request_payload['longitude'], @request_payload['latitude'])
  { ride: payload }.to_json if success
end

put '/ride/finish' do
  contract = FinishRideContract.new
  errors = contract.call(@request_payload).errors.to_h
  halt 400, errors.to_json if errors.any?
  success, payload = FinishRide.new.call(@request_payload['identification'], @request_payload['longitude'], @request_payload['latitude'])
  halt 409, { message: payload}.to_json unless success
  { ride: payload }.to_json
end
