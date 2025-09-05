# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable, :lockable

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

  # Custom validations
  validates :first_name, presence: true
  validates :last_name, presence: true
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

  # Override Devise methods to include is_active check
  def active_for_authentication?
    super && is_active?
  end

  def inactive_message
    is_active? ? super : :inactive
  end
end
