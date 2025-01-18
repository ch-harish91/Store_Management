class StoresController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  before_action :authenticate_user
  before_action :set_store, only: %i[show edit update destroy]

  def index
    @stores = if params[:query].present?
                Store.where('name LIKE ?', "%#{params[:query]}%")
              else
                Store.all
              end
  end

  def show; end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to store_path(@store), notice: 'Store was successfully created.'
    else
      flash.now[:alert] = 'Failed to create store. Please fix the errors below.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @store.update(store_params)
      redirect_to store_path(@store), notice: 'Store was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update store. Please fix the errors below.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @store.destroy
      redirect_to stores_path, notice: 'Store was successfully deleted.'
    else
      redirect_to stores_path, alert: 'Failed to delete store.'
    end
  end

  def update_rating
    @store = Store.find(params[:id])

    # Find or initialize the rating for the store
    @rating = Rating.find_or_initialize_by(store_id: @store.id)

    # Update the rating with the provided value
    if @rating.update(rating_value: params[:rating], user_id: current_user.id)
      redirect_to stores_path
    end
  end

  private

  def set_store
    @store = Store.find_by(id: params[:id])
    return if @store

    redirect_to stores_path, alert: 'Store not found.'
  end

  def store_params
    params.require(:store).permit(:name, :address, :overall_rating, :my_rating, :submit_rating_option,
                                  :modify_rating_option)
  end
end
