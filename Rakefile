require 'mongoid'
require_relative 'app/models/rider.rb'
require_relative 'app/models/driver.rb'
namespace :db do
  task :seed do
    Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))
    puts '---------------------->>Begining'
    Rider.destroy_all
    Driver.destroy_all
    rider_params = {
                    email: 'ridertest01@example.com',
                    full_name: 'Rider for test 01',
                    identification: '702809283107',
                    payment_source: {
                      type: 'CARD',
                      token: 10354,
                      card_token: 'tok_test_10628_e9fde80Bc6Cffd1DdFB3b59622F48ef9'
                    }
                  }
    driver_params = {
                    email: 'drivertest01@example.com',
                    full_name: 'Driver for test 01',
                    identification: '458798489797',
                  }
    Driver.create!(driver_params)
    Rider.create!(rider_params)
    puts '---------------------->>End'
  end

  task :migrate do
  end
end
