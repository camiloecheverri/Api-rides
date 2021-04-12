require 'aasm'
class User
  include Mongoid::Document
  include AASM

  field :email, type: String
  field :status, type: String
  field :full_name, type: String
  field :identification, type: String

  validates :email, :full_name, :identification, presence: true
  validates :email, :identification, uniqueness: true
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }

  aasm column: :status do
    state :free, initial: true
    state :bussy

    event :in_ride do
      transitions from: :free, to: :bussy
    end
    event :avaible do
      transitions from: :bussy, to: :free
    end
  end
end
