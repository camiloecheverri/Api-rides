require 'sinatra'
require 'mongoid'

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

require_relative 'app/controllers/rides_controller'
require_relative 'app/controllers/wompi_controller'

run Sinatra::Application
