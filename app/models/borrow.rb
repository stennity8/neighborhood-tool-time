class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :equipment
  validates :start_time, :anticipated_end_time, presence: true
  
    # scope :currently_lent, -> (id) {where("returned = ?", false).left_outer_joins(:equipment).where("available = ? AND equipment.user_id = ?", false, id)}
    # scope :pending_return_verification, -> (id) {where("returned = ?", true).left_outer_joins(:equipment).where("available = ? AND equipment.user_id = ?", false, id)}
    


  
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
