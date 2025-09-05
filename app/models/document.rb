# frozen_string_literal: true

class Document < ApplicationRecord
  belongs_to :employee, optional: true, inverse_of: :documents
  belongs_to :truck, optional: true, inverse_of: :documents
  belongs_to :citerne, optional: true, foreign_key: 'citernes_id', inverse_of: :documents

  validates :title, presence: true
  validates :document_type, presence: true, inclusion: { in: %w(invoice delivery_note contract maintenance_report other) }
  validates :status, presence: true, inclusion: { in: %w(draft active archived expired) }

  scope :active, -> { where(status: 'active') }
  scope :by_type, ->(type) { where(document_type: type) }
  scope :expired, -> { where(expiry_date: ...Time.zone.current) }
  scope :expiring_soon, -> { where('expiry_date BETWEEN ? AND ?', Time.zone.current, 30.days.from_now) }

  def expired?
    expiry_date.present? && expiry_date < Time.zone.current
  end

  def expiring_soon?
    expiry_date.present? && expiry_date.between?(Time.zone.current, 30.days.from_now)
  end
end
