class User < ApplicationRecord
  has_secure_password
  # belongs_to :role
  has_many :addresses, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
