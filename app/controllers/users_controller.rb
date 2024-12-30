class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.addresses.destroy_all if @user.addresses.any?

    if @user.destroy
      render json: { message: 'User successfully deleted' }, status: :no_content
    else
      render json: { error: 'Unable to delete user' }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    render json: { error: 'User not found' }, status: :not_found unless @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role_id)
  end
end
