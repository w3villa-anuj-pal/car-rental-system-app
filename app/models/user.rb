class User < ApplicationRecord
  include ImageUploader::Attachment(:image)
  rolify
  has_many :car_users
  has_many :cars, through: :car_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable,
         :omniauthable, omniauth_providers: [:github, :google_oauth2]
  validates :phone_number,uniqueness: {case_sensitive: false}       
         
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first

    user ||= User.create(
      email: data["email"],
      password: Devise.friendly_token[0, 20]
    )

    user.name = access_token.info.name
    user.provider = access_token.provider
    user.uid = access_token.uid
    user.save

    user
  end
end
