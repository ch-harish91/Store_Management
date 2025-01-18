class ApplicationController < ActionController::Base
  helper_method :current_user, :role

  private

  # def current_user
  #   User.find(session[:user_id]) if session[:user_id]
  # end

  def authenticate_user
    return if current_user

    redirect_to login_path, alert: 'You need to sign in before continuing.'
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def role
    current_user.role.name
  end
end
