# frozen_string_literal: true

class Citerne < ApplicationRecord
  has_many :trucks, dependent: :nullify
  has_many :documents, dependent: :nullify
  has_many :delivery_notes, dependent: :nullify

  validates :plate_number, presence: true, uniqueness: true
  validates :chassis_number, presence: true, uniqueness: true
  validates :capacity, presence: true
  validates :status, presence: true, inclusion: { in: %w(available in_use maintenance out_of_service) }

  scope :available, -> { where(status: 'available') }
  scope :in_use, -> { where(status: 'in_use') }
  scope :maintenance, -> { where(status: 'maintenance') }
end
