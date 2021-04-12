require_relative './user'
require_relative './ride'
class Driver < User
  has_many :rides
end
