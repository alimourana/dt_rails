# frozen_string_literal: true

class Employee < ApplicationRecord
  belongs_to :user
  has_many :trucks, dependent: :nullify
  has_many :documents, dependent: :nullify
  has_many :delivery_notes, dependent: :nullify

  validates :matricule, presence: true, uniqueness: true
  validates :department, presence: true
  validates :position, presence: true
  validates :status, presence: true, inclusion: { in: %w(active inactive suspended terminated) }
  validates :salary, presence: true

  delegate :first_name, :last_name, :email, :full_name, to: :user
end
