class DeliveryNote < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :truck, optional: true
  belongs_to :citerne, optional: true
  
  validates :number, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w[pending in_transit delivered returned cancelled] }
  validates :origin, presence: true
  validates :destination, presence: true
  validates :gasoline_quantity, presence: true
  validates :diesel_quantity, presence: true
  validates :total_quantity, presence: true
  validates :missing_quantity, presence: true
  validates :missing_description, presence: true
  validates :updated_by, presence: true
  validates :created_by, presence: true
  validates :issued_date, presence: true
  validates :delivery_date, presence: true
  validates :return_date, presence: true
  
  scope :pending, -> { where(status: 'pending') }
  scope :in_transit, -> { where(status: 'in_transit') }
  scope :delivered, -> { where(status: 'delivered') }
  scope :returned, -> { where(status: 'returned') }
  scope :by_date_range, ->(start_date, end_date) { where(issued_date: start_date..end_date) }
  
  def total_fuel_quantity
    gasoline_quantity.to_f + diesel_quantity.to_f
  end
  
  def has_missing_items?
    missing_quantity.to_f > 0
  end
  
  def delivery_duration
    return nil unless delivery_date && issued_date
    (delivery_date - issued_date).to_i
  end
end
