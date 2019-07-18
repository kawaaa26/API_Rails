class UsersController < ApplicationController
  before_action :set_user, only: %i(update destroy)

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.create(user: params[:user])
    render json: @user
  end

  def update
    @user.update_attributes(user: params[:user])
    render json: @user
  end

  def dsetroy
    if @user.destroy
      head :no_content, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    User.find(params[:id])
  end
end
