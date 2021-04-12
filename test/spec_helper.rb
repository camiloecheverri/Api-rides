require_relative '../app/main'
require "rack/test"

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
