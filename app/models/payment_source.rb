require_relative './rider'
class PaymentSource
  include Mongoid::Document

  field :type, type: String
  field :token, type: Integer
  field :card_token, type: String

  embedded_in :rider
end
