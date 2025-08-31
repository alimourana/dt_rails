# frozen_string_literal: true

class Truck < ApplicationRecord
  belongs_to :employee, inverse_of: :trucks
  belongs_to :citerne, foreign_key: 'citernes_id', inverse_of: :trucks
  has_many :documents, dependent: :nullify, inverse_of: :truck
  has_many :delivery_notes, dependent: :nullify, inverse_of: :truck

  validates :make, presence: true
  validates :model, presence: true
  validates :plate_number, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w(available in_use maintenance out_of_service) }
  validates :vin, presence: true, uniqueness: true

  scope :available, -> { where(status: 'available') }
  scope :in_use, -> { where(status: 'in_use') }
  scope :maintenance, -> { where(status: 'maintenance') }

  def full_description
    "#{make} #{model} - #{plate_number}"
  end
end
