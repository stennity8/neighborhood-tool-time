class Equipment < ApplicationRecord
  belongs_to :user
  has_many :borrows
  has_many :users, through: :borrows
  has_many :equipment_categories
  has_many :categories, through: :equipment_categories

  scope :unavailable, -> { where(available: false) }

  def self.lent_out
    unavailable.collect do |item|
      item.borrows.where("start_time <= ? AND end_time > ?", DateTime.now, DateTime.now)
    end.flatten
  end

end
