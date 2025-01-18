class Role < ApplicationRecord
  # Associations
  has_many :users

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
