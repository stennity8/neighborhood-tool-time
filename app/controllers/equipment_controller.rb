class EquipmentController < ApplicationController
  include ApplicationHelper
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
    if validate_user(params[:user_id])
      redirect_to root_path
    else  
      @equipment = Equipment.new(equipment_params)
      @equipment.user_id = params[:user_id]

      if @equipment.save
        redirect_to user_equipment_index_path
      else
      render :new
      end
    end
  end
  
  def edit
    @equipment = Equipment.find(params[:id])
  end
  
  def update
    @equipment = Equipment.find(params[:id])
    equipment_user_id = @equipment.user_id

    if validate_user(equipment_user_id)
      redirect_to root_path
    else
      @equipment.categories.clear
      if @equipment.update(equipment_params)
        redirect_to user_equipment_index_path
      else
        render :update
      end
    end
  end
  
  def destroy
    @equipment = Equipment.find(params[:id])
    equipment_user_id = @equipment.user_id

    if validate_user(equipment_user_id)
      redirect_to root_path
    else
      if @equipment.borrows.empty?
        @equipment.categories.clear
        @equipment.destroy

        redirect_to user_equipment_index_path
      else
        flash[:danger] = "This tool can not be deleted. It is or has been lent out and a record is being kept."
        redirect_to user_equipment_index_path
      end
    end
  end

  private 

  def equipment_params
    params.require(:equipment).permit(:name, :brand, :description, :pic_url, category_ids:[], categories_attributes: [:title])
  end
end
