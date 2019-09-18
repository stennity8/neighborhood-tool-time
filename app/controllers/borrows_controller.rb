class BorrowsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!

  def lent_equipment
    if validate_user(user_id)
      redirect_to root_path
    else
      @equipment = current_user.owned_equipments
      @current_borrows = current_user.current_lent
      @pending_return_borrows = current_user.current_lent_pending_return_verification
    end
  end
  
  def borrowed_equipment
    if validate_user(user_id)
      redirect_to root_path
    else
      @equipment = current_user.equipments
      @current_borrows = current_user.current_borrows
      @pending_return_borrows = current_user.current_borrows_pending_return_verification
    end
  end
  
  def new
    if validate_user(user_id)
      redirect_to root_path
    else
      @borrow = Borrow.new
      @equipment = Equipment.find(borrow_id)
    end
  end
  
  def create
    if validate_user(user_id)
      redirect_to root_path
    else
      @borrow = Borrow.new(borrow_params)
      @borrow.user_id = user_id
      if @borrow.save
        @equipment = Equipment.find(borrow_params[:equipment_id])
        @equipment.update(available: false)

        redirect_to user_borrowed_tools_path
      else
        render :new
      end
    end
  end
  
  def edit
    if validate_user(user_id)

      redirect_to root_path
    else
      @borrow = Borrow.find(borrow_id)
      @equipment = @borrow.equipment
    end
  end
  
  def update
    @borrow = Borrow.find(borrow_id)
    
    # Check for return param
    if borrow_params[:returned]
      # If the user marks the tool returned before the borrower
      if current_user.id != @borrow.user_id  
        @borrow.update(borrow_params)
        @borrow.end_time = Date.current.strftime('%Y-%m-%d')
        @borrow.return_verified = true
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
    if validate_user(user_id)
      redirect_to root_path
    else
      @borrow = Borrow.find(borrow_id)
      @borrow.destroy
      flash[:danger] = "The borrow has been deleted."

      redirect_to user_borrowed_tools_path
    end
  end

  private 

  def user_id
    params[:user_id]
  end

  def borrow_id
    params[:id]
  end

  def borrow_params
    params.require(:borrow).permit(:start_time, :end_time, :returned, :user_id, :equipment_id, :anticipated_end_time)
  end

end
