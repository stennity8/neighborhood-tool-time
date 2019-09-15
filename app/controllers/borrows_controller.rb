class BorrowsController < ApplicationController
  before_action :authenticate_user!

  def lent_equipment
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
  end
  
  def create
    @borrow = Borrow.new(borrow_params)
    @borrow.user_id = params[:user_id]
    binding.pry
    @borrow.save

    redirect_to user_equipment_index_path
  end
  
  def edit
    @equipment = User.find(params[:user_id])
    @borrow = Borrow.find(params[:id])
  end
  
  def update
    @borrow = Borrow.find(params[:id])
    @borrow.update(borrow_params)
    
    redirect_to user_equipment_index_path
  end
  
  def destroy
    binding.pry
    @borrow = Borrow.find(params[:id])

    # if @equipment.borrows.empty?
    #   @equipment.categories.clear
    #   @equipment.destroy
    #   redirect_to user_equipment_index_path
    # else
    #   flash[:danger] = "This tool can not be deleted. It is or has been lent out and a record is being kept."
    #   redirect_to user_equipment_index_path
    # end
  end

  private 

  def borrow_params
    params.require(:borrows).permit(:start_time, :end_time, :returned, :user_id, :equipment_id)
  end

end
