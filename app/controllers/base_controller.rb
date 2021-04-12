require 'json'
class BaseController < Sinatra::Base
  error do
    content_type :json
    status 400
    {result: 'error', message: e.message}.to_json
  end

  before do
    request.body.rewind
    @request_payload = JSON.parse request.body.read
  end
end
