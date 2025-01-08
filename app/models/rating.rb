class Rating < ApplicationRecord
  belongs_to :store
  belongs_to :user
  validates :rating_value, presence: true, numericality: { only_integer: true, in: 1..5 }
  validates :store_id, presence: true
  validates :user_id, presence: true
end
