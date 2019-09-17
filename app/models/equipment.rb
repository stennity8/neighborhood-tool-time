class Equipment < ApplicationRecord
  belongs_to :user
  has_many :borrowsEqui
  has_many :users, through: :borrows
  has_many :equipment_categories
  has_many :categories, through: :equipment_categories

  scope :unavailable, -> { where(available: false) }
  scope :filter_equipment, -> (params) {left_joins(:categories).where("LOWER(title) = ?", params)}

  def self.search(params)
    left_joins(:categories).where("LOWER(name) LIKE :search_term OR LOWER(brand) LIKE :search_term OR LOWER(description) LIKE :search_term OR LOWER(title) LIKE :search_term", search_term: "%#{params}%")
  end

  def category_ids=(category_ids)
    category_ids.each do |category_id|
      self.categories << Category.find_by(id: category_id) if !category_id.empty?
    end
  end
  
  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      self.categories << Category.find_or_create_by(category_attribute) if !category_attribute[:title].empty?
    end
  end

end
