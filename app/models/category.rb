class Category < ApplicationRecord
  has_many :equipment_categories
  has_many :equipments, through: :equipment_categories

  scope :alpha, -> { order(:title) }

end
