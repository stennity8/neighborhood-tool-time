class BorrowsController < ApplicationController
  before_action :authenticate_user!

  def borrowed_equipment
    @equipment = current_user.equipments
    @borrows = current_user.borrows
    
  end

  def lent_equipment
  end

end
