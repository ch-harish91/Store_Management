class Store < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :users
  has_one :store_admin
  belongs_to :user

  validates :store_owner, presence: true

  def calucate_rating
    ratings.sum(:rating_value)
  end

  def get_user_rating(user_id)
    ratings.where(user_id: user_id).first&.rating_value || 0
  end
end
