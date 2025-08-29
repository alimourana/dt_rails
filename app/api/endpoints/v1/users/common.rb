# frozen_string_literal: true

module Endpoints
  module V1
    module Users
      module Common
        extend ActiveSupport::Concern

        included do
          helpers do
            def user_exists!
              user = User.find_by(email: params[:email])
        
              if user
                error!(Strings::ERROR_USER_EXISTS, 401)
              end
            end
          end
        end
      end
    end
  end
end