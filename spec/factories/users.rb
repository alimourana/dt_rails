# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name do
      Faker::Name.first_name
    end
    last_name do
      Faker::Name.last_name
    end
    email do
      Faker::Internet.unique.email
    end
    phone_number do
      Faker::PhoneNumber.phone_number
    end
    address_line do
      Faker::Address.street_address
    end
    city do
      Faker::Address.city
    end
    state do
      Faker::Address.state
    end
    country do
      Faker::Address.country
    end
    role do
      %w(user admin manager).sample
    end
    is_active do
      [true, false].sample
    end
    encrypted_password { 'password123' }
  end

  trait :admin do
    role { 'admin' }
  end

  trait :manager do
    role { 'manager' }
  end

  trait :regular_user do
    role { 'user' }
  end

  trait :active do
    is_active { true }
  end

  trait :inactive do
    is_active { false }
  end
end
