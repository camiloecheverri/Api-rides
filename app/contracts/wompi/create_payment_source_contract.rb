require 'dry-validation'

require_relative '../../models/rider'
class CreatePaymentSourceContract < Dry::Validation::Contract
  params do
    required(:identification).filled(:string)
    required(:card_tokenization).value(:string)
  end

  rule(:identification) do
    unless Rider.where(identification: value).any?
      key.failure('identification does not match any rider')
    end
  end

  rule(:card_tokenization) do
    if Rider.where({ 'payment_source.card_token' => value }).any?
      key.failure('card tokenization is already in use')
    end
  end
end
