module Endpoints
  class Base < Grape::API
    mount Endpoints::V1::Users::List
  end
end