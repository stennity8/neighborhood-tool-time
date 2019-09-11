class Category < ApplicationRecord
  has_many :equipment_categories
  has_many :equipments, through: :equipment_categories
end
