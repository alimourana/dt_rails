class BillingRate < ApplicationRecord
  validates :origin, presence: true
  validates :destination, presence: true
  validates :rate, presence: true, numericality: { greater_than: 0 }
  
  scope :active, -> { where(status: 'active') }
  scope :by_route, ->(origin, destination) { where(origin: origin, destination: destination) }
end
