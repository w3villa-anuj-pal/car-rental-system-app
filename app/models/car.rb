class Car < ApplicationRecord
  has_one_attached :image
  has_many :car_users
  has_many :users, through: :car_users

  validates :car_name, :vehicle_no, :captain_name, :seater, :vehicle_type, :image, presence: true
  validates :vehicle_no, uniqueness: { case_sensitive: false },length: {in: 9..10}
end
