class Document < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :truck, optional: true
  belongs_to :citerne, optional: true
  
  validates :title, presence: true
  validates :type, presence: true, inclusion: { in: %w[invoice delivery_note contract maintenance_report other] }
  validates :status, presence: true, inclusion: { in: %w[draft active archived expired] }
  
  scope :active, -> { where(status: 'active') }
  scope :by_type, ->(type) { where(type: type) }
  scope :expired, -> { where('expiry_date < ?', Date.current) }
  scope :expiring_soon, -> { where('expiry_date BETWEEN ? AND ?', Date.current, 30.days.from_now) }
  
  def expired?
    expiry_date.present? && expiry_date < Date.current
  end
  
  def expiring_soon?
    expiry_date.present? && expiry_date.between?(Date.current, 30.days.from_now)
  end
end
