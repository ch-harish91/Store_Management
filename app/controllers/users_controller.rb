class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  before_action :set_user, only: %i[show update edit destroy]

  def index
    @users = User.all
    # Render the index view (no need to return JSON)
  end

  def show
    # Render the show view
  end

  def new
    @user = User.new
    # Render the new view (no need to return JSON)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User created successfully!'
    else
      flash.now[:alert] = 'Error creating user. Please check the form for errors.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # Ensure @user is set in before_action
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User successfully updated'
    else
      flash.now[:error] = 'Please fix the errors below'
      render :edit
    end
  end

  def destroy
    @user.addresses.destroy_all if @user.addresses.any?

    if @user.destroy
      redirect_to users_path, notice: 'User successfully deleted'
    else
      redirect_to users_path, alert: 'Unable to delete user'
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return if @user

    redirect_to users_path, alert: 'User not found'
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

