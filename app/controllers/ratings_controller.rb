class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def show
    @rating = Rating.find(params[:id])
  end

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      redirect_to @rating, notice: 'Rating was successfully created.'
    else
      render :new
    end
  end

  def update
    @rating = Rating.find(params[:id])
    if @rating.update(rating_params)
      redirect_to @rating, notice: 'Rating was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy
    redirect_to ratings_url, notice: 'Rating was successfully destroyed.'
  end

  private

  def rating_params
    params.require(:rating).permit(:rating_value, :store_id, :user_id)
  end
end
