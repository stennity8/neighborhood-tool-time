class BorrowsController < ApplicationController
  before_action :authenticate_user!

  def lent_equipment
    @equipment = current_user.owned_equipments
    @borrows = Borrow.user_borrows(@equipment)
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
    @borrow.update(borrow_params)
    
    redirect_to user_borrowed_tools_path
  end
  
  def destroy
    binding.pry
    @borrow = Borrow.find(params[:id])
    @borrow.destroy
    flash[:danger] = "The borrow has been deleted."

    redirect_to user_borrowed_tools_path

  end

  private 

  def borrow_params
    params.require(:borrow).permit(:start_time, :end_time, :returned, :user_id, :equipment_id)
  end

end
