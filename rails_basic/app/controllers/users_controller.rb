class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]

  before_action :authenticate, only: [:logout, :edit, :get_user]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if !@user.authenticate(params[:user][:current_password])
      error = {current_password: ["it's wrong"]}
      render json: error, status: :unauthorized
    end

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # POST /users
  def login
    @user = User.find_by_email(params[:user][:email])

    if @user
      if @user.authenticate(params[:user][:password])
        render json: @user, status: :accepted, location: @user
      else
        error = {password: [I18n.t(:its_wrong)]}
        render json: error, status: :unauthorized
      end
    else
      error = {email: [I18n.t(:not_registered)]}
      render json: error, status: :unauthorized
    end
  end

  # POST /users/logout
  def logout
    render json: @user, status: :accepted, location: @user
  end

  # POST /users/edit
  def edit
    params[:user].delete_if { |key, value| value.empty? }
    params[:user].delete(:email) if params[:user][:email] == @user.email
    params[:user][:password_confirmation] = "" if params[:user].has_key?(:password)

    if !@user.authenticate(params[:user][:current_password])
      error = {current_password: [I18n.t(:its_wrong)]}
      render json: error, status: :unauthorized
    else
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  # POST /users/get_user
  def get_user
    render json: @user, status: :accepted, location: @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
