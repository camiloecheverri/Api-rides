# Api rider - API rest

## Stack

- MongoDB 4.2
- Mongoid 7
- Ruby 2.7.1
- Sinatra 2.0

## Setup - for development
 - Run `bundle install`
 - Run `rackup`
 On project directory, after this you can make requests on localhost:9292

## End points
### for riders
 - post /ride - creates a ride
 @params identification -> rider personal identification, latitude -> rider current latitude, longitude -> rider current longitude
 - put /payment-source - create a payment source for rider and assigns it.
 @params identification -> rider personal identification, card_tokenization -> card tokenization from wompi
### for drivers
 - put /ride - finish a ride
 @params identification -> driver personal identification, latitude -> finish ride latitude, longitude -> finish ride longitude

### Database
Run MongoDB server with m
```
m use 4.2.0 --dbpath ~/data/mongodb/4.2.0
```
Make a mongoid.yml file based on mongoid_example.yml and then seed databases
```
$ RACK_ENV=development rake db:seed
```

## Testing

Seeding the application, for the first time...
```
$ RAILS_ENV=test rails db:seed:test
```
Run unit tests
```
$ rspec . test/unit_spec.rb
```
Run integration tests
```
$ rspec . test/integration_spec.rb
```
### Things to do better

- Upgrade rake seeds
- Add namespacing to classes name
- Add a .env to manage some variables, like public and private wompi test keys (or production if it's the case)
