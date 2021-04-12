require "sinatra/base"

require_relative './controllers/rides_controller'
require_relative './controllers/wompi_controller'
class Main < Sinatra::Base
  use RidesController
  use WompiController
end
