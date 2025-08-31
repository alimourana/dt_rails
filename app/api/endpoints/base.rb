# frozen_string_literal: true

module Endpoints
  class Base < Grape::API
    # Users
    mount Endpoints::V1::Users::Delete
    mount Endpoints::V1::Users::Create
    mount Endpoints::V1::Users::Get
    mount Endpoints::V1::Users::List
    mount Endpoints::V1::Users::Update
  end
end
