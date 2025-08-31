# frozen_string_literal: true

module Endpoints
  module V1
    module Users
      module Common
        extend ActiveSupport::Concern

        included do
          include Endpoints::ApiDefault

          helpers do
            def user
              @user ||= if params[:id]
                          User.find(params[:id])
                        else
                          User.find_by(email: params[:email])
                        end
            end

            def user_exists!
              if user.present?
                error!(Strings::ERROR_USER_EXISTS, 401)
              end
            end
          end
        end
      end
    end
  end
end
