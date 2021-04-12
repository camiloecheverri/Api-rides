require_relative './ride'
class Payment
  include Mongoid::Document
  include AASM

  field :reference_id, type: String
  field :status, type: String

  validates :reference_id, presence: true

  belongs_to :ride

  aasm column: :status do
    state :pending, initial: true
    state :approved
    state :declined
    state :error
    state :voided

    event :bill do
      transitions from: :pending, to: :approved
    end
    event :decline do
      transitions from: :pending, to: :declined
    end
    event :void do
      transitions from: :pending, to: :voided
    end
    event :error do
      transitions from: :pending, to: :error
    end
  end
end
