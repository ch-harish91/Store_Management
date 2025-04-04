class User < ApplicationRecord
  has_secure_password
  has_many :addresses, dependent: :destroy
  has_many :ratings, dependent: :destroy
  belongs_to :store, optional: true
  has_many :stores
  belongs_to :role

  validates :name, presence: true, length: { minimum: 7, maximum: 60 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 5, maximum: 16 }

  before_validation :set_default_role

  private

  def set_default_role
    self.role_id = fetch_default_role
  end

  def fetch_default_role
    Role.find_by_name('normal_user').id || 1
  end
end

