class BorrowsController < ApplicationController
  before_action :authenticate_user!

  def lent_equipment
    @equipment = current_user.owned_equipments
    @current_borrows = Borrow.currently_lent(current_user.id)
    @pending_return_borrows = Borrow.pending_return_verification(current_user.id)
  end

  def borrowed_equipment
    @equipment = current_user.equipments
    @borrows = current_user.borrows
  end

  
  def show
    @user = User.find(params[:user_id])
    @borrow = [Borrow.find(params[:id])]
  end
  
  def new
    @borrow = Borrow.new
    @equipment = Equipment.find(params[:id])
  end
  
  def create
    @borrow = Borrow.new(borrow_params)
    @borrow.user_id = params[:user_id]
    @borrow.save

    redirect_to user_equipment_index_path
  end
  
  def edit
    @borrow = Borrow.find(params[:id])
    @equipment = @borrow.equipment
  end
  
  def update
    @borrow = Borrow.find(params[:id])
    
    # Check for return param
    if borrow_params[:returned]
      # If the user marks the tool returned before the borrower
      if current_user.id != @borrow.user_id  
        @borrow.update(borrow_params)
        @borrow.end_time = Date.current.strftime('%Y-%m-%d')
        @borrow.equipment.available = true
        @borrow.save
        @borrow.equipment.save

        redirect_to user_lent_tools_path
      else
      # If borrower marks tool returned
        @borrow.update(borrow_params)
        @borrow.end_time = Date.current
        @borrow.save
        
        redirect_to user_borrowed_tools_path
      end
    else
      @borrow.update(borrow_params)
      
      redirect_to user_borrowed_tools_path
    end
    
  end
  
  def destroy
    @borrow = Borrow.find(params[:id])
    @borrow.destroy
    flash[:danger] = "The borrow has been deleted."

    redirect_to user_borrowed_tools_path

  end

  private 

  def borrow_params
    params.require(:borrow).permit(:start_time, :end_time, :returned, :user_id, :equipment_id, :anticipated_end_time)
  end

end
