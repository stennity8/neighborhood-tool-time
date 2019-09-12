class Equipment < ApplicationRecord
  belongs_to :user
  has_many :borrows
  has_many :users, through: :borrows
  has_many :equipment_categories
  has_many :categories, through: :equipment_categories

  scope :lent, -> { where(available: false) }
  # scope :lent_out, -> { lent.left_outer_join(:borrows).where("start_time: <= ?", DateTime.now).where("end_time: > ?", DateTime.now) }
  # scope :lent_out, -> { lent.left_outer_joins(:borrows) }
  # scope :lend, -> { left_joins(:borrows).where(available: false) }
  def self.lent_out
    lent.collect do |item|
      item.borrows.where("start_time <= ? AND end_time > ?", DateTime.now, DateTime.now)

    end
  end

end
