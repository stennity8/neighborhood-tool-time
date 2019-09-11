class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github]
  has_many :owned_equipments, foreign_key: "user_id", class_name: "Equipment"
  has_many :borrows
  has_many :equipments, through: :borrows

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.extra.raw_info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   
   end
  end

end
