# frozen_string_literal: true

# Service to update a user record via provided params
# @param params [Hash] The parameters to update the user with
# @return [Result] A Result struct with the success flag and the updated user object
# @example
#   Users::Update.call(params: { id: 1, first_name: 'John', last_name: 'Doe' })
#   => Result.new(true, User.last)
# @example
#   Users::Update.call(params: { id: 1, first_name: 'John', last_name: 'Doe' })
#   => Result.new(false, nil)

module Users
  class Update
    include Callable

    Result = Struct.new(:success, :object)

    def initialize(params)
      @params = params
    end

    def call
      return Result.new(false, 'User not found') if user.blank?

      user.update!(build_update_params)
      Result.new(true, user)
    end

    private

    attr_reader :params

    def build_update_params
      update_params = {}
      %i(first_name last_name email phone_number address_line city state country role is_active).each do |field|
        update_params[field] = params[field] if params[field]
      end
      update_params
    end

    def user
      @user ||= User.find(params[:id])
    end
  end
end
