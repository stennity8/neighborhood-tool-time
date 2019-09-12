class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :equipment

  # scope :current, -> { where("start_time: <= ?", DateTime.now).where("end_time: > ?", DateTime.now) }


end
