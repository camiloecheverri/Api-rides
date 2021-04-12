require 'dry-validation'

require_relative '../../models/rider'
require_relative '../../models/driver'
class NewRideContract < Dry::Validation::Contract
  params do
    required(:identification).filled(:string)
    required(:latitude).value(:integer)
    required(:longitude).value(:integer)
  end

  rule(:identification) do
    unless Rider.where(identification: value).any?
      key.failure('identification does not match any rider')
    end

    if Rider.where(identification: value).first&.bussy?
      key.failure('rider has a ride in progress')
    end
  end

  rule do
    unless Driver.where(status: 'free').any?
      base.failure('Not driver avaible')
    end
  end
end
