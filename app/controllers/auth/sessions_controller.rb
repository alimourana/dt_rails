# frozen_string_literal: true

class Auth::SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  skip_before_action :verify_authenticity_token, only: %i[create destroy]

  def new
    redirect_to root_path if current_user
  end

  def create
    user = User.find_by_credentials(session_params[:email], session_params[:password])
    
    if user
      session[:user_id] = user.id
      redirect_to stored_location || root_path, notice: 'Signed in successfully.'
    else
      flash.now[:alert] = 'Invalid email or password.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out successfully.'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
