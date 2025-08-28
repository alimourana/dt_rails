# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    phone_number { Faker::PhoneNumber.phone_number }
    address_line { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    role { %w[user admin manager].sample }
    is_active { [true, false].sample }
    encrypted_password { "password123" }
  end

  trait :admin do
    role { "admin" }
  end

  trait :manager do
    role { "manager" }
  end

  trait :regular_user do
    role { "user" }
  end

  trait :active do
    is_active { true }
  end

  trait :inactive do
    is_active { false }
  end
end
