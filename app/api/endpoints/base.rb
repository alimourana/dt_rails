module Endpoints
  class Base < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    mount Endpoints::V1::Users::List
  end
end