class EquipmentController < ApplicationController
   before_action :authenticate_user!

  def index
    if params[:user_id]
      @user = current_user
      @equipment = current_user.owned_equipments
    else
      @equipment = Equipment.all
    end
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
  end

  private 

  def equipment_params
    params.require(:equipment).permit(:name, :brand, :description, :pic_url, category_ids:[], categories_attributes: [:title])
  end
end
