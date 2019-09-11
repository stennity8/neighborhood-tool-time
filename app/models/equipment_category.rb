class EquipmentCategory < ApplicationRecord
  belongs_to :equipment
  belongs_to :category
end
