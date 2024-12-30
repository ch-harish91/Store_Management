class StoresController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  before_action :set_store, only: %i[show edit update destroy]

  def index
    stores = Store.all
    render json: stores
  end

  def show
    render json: @store
  end

  def new
    store = Store.new
    render json: store
  end

  def create
    store = Store.new(store_params)
    if store.save
      render json: store, status: :created, location: store
    else
      render json: { errors: store.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    render json: @store
  end

  def update
    if @store.update(store_params)
      render json: @store
    else
      render json: { errors: @store.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @store.destroy
      render json: { message: 'Store successfully deleted', store: @store }, status: :ok
    else
      render json: { error: 'Failed to delete store' }, status: :unprocessable_entity
    end
  end

  private

  def set_store
    @store = Store.find_by(id: params[:id])
    return if @store

    render json: { error: 'Store not found' }, status: :not_found
  end

  def store_params
    params.require(:store).permit(:name, :address, :overall_rating, :my_rating, :submit_rating_option,
                                  :modify_rating_option)
  end
end
