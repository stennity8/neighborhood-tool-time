class Equipment < ApplicationRecord
  belongs_to :user
  has_many :borrows
  has_many :users, through: :borrows
  has_many :equipment_categories
  has_many :categories, through: :equipment_categories

  scope :unavailable, -> { where(available: false) }

end
