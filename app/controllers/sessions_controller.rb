class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid email or password.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to root_path, notice: 'Logged out successfully.'
  end

  def signup
    @user = User.new
  end

  def register
    user_params = register_params
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: 'Registration successful.'
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :signup, status: :unprocessable_entity
    end
  end

  private

  def register_params
    # Permitting the role as well as the other user attributes
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)

    # Ensure the role is properly assigned by finding the role by name and saving the role_id
    if user_params[:role].present?
      role = Role.find_by(name: user_params[:role])
      if role
        user_params[:role_id] = role.id # Assign role_id to user_params, not the role object
      else
        user_params.delete(:role) # Handle case where role is not found (optional: you could handle it differently)
      end
    end

    user_params
  end
end
