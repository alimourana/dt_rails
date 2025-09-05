# frozen_string_literal: true

class Auth::RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  skip_before_action :verify_authenticity_token, only: %i[create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.is_active = true
    @user.role = 'user'

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :encrypted_password,
      :phone_number, :address_line, :city, :state, :country
    )
  end
end
