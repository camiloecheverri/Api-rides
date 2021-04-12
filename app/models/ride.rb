require 'aasm'
require_relative './rider'
require_relative './driver'
require_relative './payment'
class Ride
  include Mongoid::Document
  include AASM

  field :status, type: String
  field :amount_in_cents, type: Integer
  field :starts_at, type: Time
  field :ends_at, type: Time
  field :start_location, type: Array
  field :finish_location, type: Array

  belongs_to :rider
  belongs_to :driver

  has_many :payments

  aasm column: :status do
    state :in_progress, initial: true
    state :finished

    event :finish do
      transitions from: :in_progress, to: :finished
    end
  end

  def payment_in_progress?
    self.payments.where(status: 'pending').any?
  end
end
