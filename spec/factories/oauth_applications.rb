# frozen_string_literal: true

FactoryBot.define do
  factory :oauth_application, class: "OauthApplication" do
    name { Faker::App.name + Faker::Number.number(digits: 10).to_s }
    redirect_uri { "https://djoulde_transport.com" }
    scopes { "read write" }

    factory :internal_oauth_application do
      scopes { "read write" }
      created_by { nil }
    end
  end
end
