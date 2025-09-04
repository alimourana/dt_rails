# frozen_string_literal: true

class Oauth::ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_application, only: %i[show edit update destroy]
  before_action :authorize_application, only: %i[show edit update destroy]

  # GET /oauth/applications
  def index
    @applications = policy_scope(OauthApplication)
    authorize OauthApplication
  end

  # GET /oauth/applications/1
  def show
    authorize @application
  end

  # GET /oauth/applications/new
  def new
    @application = OauthApplication.new
    authorize @application
  end

  # GET /oauth/applications/1/edit
  def edit
    authorize @application
  end

  # POST /oauth/applications
  def create
    @application = OauthApplication.new(application_params)
    @application.owner = current_user
    @application.created_by_id = current_user.id

    authorize @application

    if @application.save
      redirect_to @application, notice: 'Application was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /oauth/applications/1
  def update
    authorize @application

    if @application.update(application_params)
      redirect_to @application, notice: 'Application was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /oauth/applications/1
  def destroy
    authorize @application
    @application.destroy
    redirect_to oauth_applications_url, notice: 'Application was successfully deleted.'
  end

  private

  def set_application
    @application = OauthApplication.find(params[:id])
  end

  def authorize_application
    authorize @application
  end

  def application_params
    params.require(:oauth_application).permit(:name, :redirect_uri, :scopes, :confidential)
  end
end
