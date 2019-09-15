class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :equipment

  def borrow_date
      self.start_time.strftime("%A, %b %d, %Y") if self.start_time
  end
  
  def return_date
      self.end_time.strftime("%A, %b %d, %Y") if self.end_time
  end
  
end
