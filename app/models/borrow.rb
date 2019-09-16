class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :equipment
  validates :start_time, :anticipated_end_time, presence: true
  
  def date(type)
    if type == 'start'
      self.start_time.strftime("%A, %b %d, %Y") if self.start_time
    elsif type == 'end'
      self.end_time.strftime("%A, %b %d, %Y") if self.end_time
    elsif type == 'anticipated_end'
      self.anticipated_end_time.strftime("%A, %b %d, %Y") if self.anticipated_end_time
    end      
  end
  
  def self.user_borrows(equipment)
    equipment.each.collect do |equipment|
      equipment.borrows
    end.flatten
  end
end
