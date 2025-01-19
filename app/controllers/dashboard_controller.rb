class DashboardController < ApplicationController
  before_action :authenticate_user
  before_action :set_user, only: [:assign_store_admin]

  def index
    redirect_to stores_path if role == 'normal_user'

    if role == 'system_admin'
      @stores = Store.all
      @users = User.all
      @store_count = @stores.count
      @user_count = @users.count
    end

    if role == 'store_owner'
      @stores = Store.where(store_owner: current_user.id)
      store_users = Rating.where(store_id: @stores.pluck(:id)).pluck(:user_id).compact
      @users = User.where(id: store_users)
      @store_count = @stores.count
      @user_count = @users.count
    end

    params[:tab] ||= 'stores'
  end

  def assign_store_admin
    @store = Store.find(params[:store_id])

    if @user.update(role: 'store_admin', store_id: @store.id)
      redirect_to dashboard_path, notice: 'Store admin assigned successfully.'
    else
      redirect_to dashboard_path, alert: 'Error assigning store admin.'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end