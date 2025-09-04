# frozen_string_literal: true

class User < ApplicationRecord
  has_one :employee, dependent: :destroy

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :oauth_applications, class_name: 'OauthApplication', as: :owner

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :encrypted_password, presence: true
  validates :phone_number, presence: true
  validates :address_line, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :role, inclusion: { in: %w(user admin manager) }
  validates :is_active, inclusion: { in: [true, false] }

  enum :role, {
    user: 0,
    admin: 1,
    manager: 2
  }

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    role == 'admin'
  end

  def manager?
    role == 'manager'
  end

  def user?
    role == 'user'
  end
end
