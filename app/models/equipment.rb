class Equipment < ApplicationRecord
  belongs_to :user
  has_many :borrows
  has_many :users, through: :borrows
  has_many :equipment_categories
  has_many :categories, through: :equipment_categories

  scope :unavailable, -> { where(available: false) }

  def category_ids=(category_ids)
    category_ids.each do |category_id|
      self.categories << Category.find_by(id: category_id) if !category_id.empty?
    end
  end
  
  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.categories << category
    end
  end

end
