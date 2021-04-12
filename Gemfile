source 'https://rubygems.org'

ruby '2.7.1'

gem 'sinatra', '~> 2.0'
gem 'sinatra-contrib'

# state machine
gem 'aasm', '~> 5.0.5'

# api data validation
gem 'dry-validation', '~> 1.6'

# database and steroids
gem 'mongoid', github: 'mongodb/mongoid', branch: 'master'

gem 'puma'

gem 'rake'

# tool for debuggin
gem 'pry', '~> 0.13.1'

gem 'geocoder'


# for http api connections
gem "typhoeus"

group :test do
  # helps to clean the db each time running test
  gem 'database_cleaner'
  # test
  gem 'rspec', '~> 3.10'
  gem 'rack-test'
end
