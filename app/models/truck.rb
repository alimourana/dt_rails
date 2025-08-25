class Truck < ApplicationRecord
  belongs_to :employee
  belongs_to :citerne
  has_many :documents, dependent: :nullify
  has_many :delivery_notes, dependent: :nullify
  
  validates :make, presence: true
  validates :model, presence: true
  validates :plate_number, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w[available in_use maintenance out_of_service] }
  validates :vin, presence: true, uniqueness: true
  
  scope :available, -> { where(status: 'available') }
  scope :in_use, -> { where(status: 'in_use') }
  scope :maintenance, -> { where(status: 'maintenance') }
  
  def full_description
    "#{make} #{model} - #{plate_number}"
  end
end
