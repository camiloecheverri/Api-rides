require 'dry-validation'

require_relative '../../models/driver'
class FinishRideContract < Dry::Validation::Contract
  params do
    required(:identification).filled(:string)
    required(:latitude).value(:integer)
    required(:longitude).value(:integer)
  end

  rule(:identification) do
    driver = Driver.where(identification: value).first
    unless driver
      key.failure('identification does not match any rider')
    end

    if driver
      unless driver.rides.where(status: 'in_progress').any?
        key.failure('Driver does not have any ride in progress')
      end
    end
  end
end
