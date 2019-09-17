class EquipmentController < ApplicationController
   before_action :authenticate_user!

  def index
    if params[:user_id]
      @user = current_user
      @equipment = current_user.owned_equipments
    else
      @equipment = Equipment.all
    end

    # Search input
    @equipment = @equipment.search(params[:q].downcase) if params[:q] && !params[:q].empty?
    # Category filter
    @equipment = @equipment.filter_equipment(params[:equipments][:categories].downcase) if params[:equipments] && params[:equipments][:categories]

  end
  
  def show
    @user = User.find(params[:user_id])
    @equipment = [Equipment.find(params[:id])]
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(equipment_params)
    @equipment.user_id = params[:user_id]
    binding.pry
    @equipment.save

    redirect_to user_equipment_index_path
  end
  
  def edit
    @equipment = Equipment.find(params[:id])
  end
  
  def update
    @equipment = Equipment.find(params[:id])
    @equipment.categories.clear
    @equipment.update(equipment_params)
    
    redirect_to user_equipment_index_path
  end
  
  def destroy
    binding.pry
    @equipment = Equipment.find(params[:id])

    if @equipment.borrows.empty?
      @equipment.categories.clear
      @equipment.destroy
      redirect_to user_equipment_index_path
    else
      flash[:danger] = "This tool can not be deleted. It is or has been lent out and a record is being kept."
      redirect_to user_equipment_index_path
    end
  end

  private 

  def equipment_params
    params.require(:equipment).permit(:name, :brand, :description, :pic_url, category_ids:[], categories_attributes: [:title])
  end
end
