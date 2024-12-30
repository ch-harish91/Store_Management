class Store < ApplicationRecord
  has_many :ratings, dependent: :destroy
end
