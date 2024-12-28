class Address < ApplicationRecord
  belongs_to :user
  
  validates :area, presence: true
  validates :city, presence: true
  validates :pincode, presence: true
end
