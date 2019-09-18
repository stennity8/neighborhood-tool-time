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

  def current_borrows
    self.borrows.where("returned = ? AND return_verified = ?", false, false).left_outer_joins(:equipment).where("available = ?", false)
  end
  
  def current_borrows_pending_return_verification
    self.borrows.where("returned = ? AND return_verified = ?", true, false).left_outer_joins(:equipment).where("available = ?", false)
  end

  def current_lent
    Borrow.where("returned = ? AND return_verified = ?", false, false).left_outer_joins(:equipment).where("available = ? AND equipment.user_id = ?", false, self.id)
  end

  def current_lent_pending_return_verification
    Borrow.where("returned = ? AND return_verified = ?", true, false).left_outer_joins(:equipment).where("available = ? AND equipment.user_id = ?", false, self.id)
  end

end
