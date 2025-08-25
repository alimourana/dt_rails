class User < ApplicationRecord
  has_one :employee, dependent: :destroy
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :encrypted_password, presence: true
  validates :phone_number, presence: true
  validates :address_line, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :role, presence: true, inclusion: { in: %w[user admin manager] }
  validates :is_active, inclusion: { in: [true, false] }
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
