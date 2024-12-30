class Rating < ApplicationRecord
  belongs_to :store
  belongs_to :user
  validates :rating_value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :store_id, presence: true
  validates :user_id, presence: true
end
