require_relative './user'
require_relative './ride'
require_relative './payment_source'
class Rider < User
  has_many :rides
  embeds_one :payment_source
end
