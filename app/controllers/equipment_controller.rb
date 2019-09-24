class EquipmentController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action only: [:new, :create, :update, :destroy] do
    validate_user(user_id)
  end
  def index
    if user_id
      @user = current_user
      @equipment = current_user.owned_equipments.alpha
    else
      @equipment = Equipment.all.alpha
    end

    # Search input
    @equipment = @equipment.search(params[:q].downcase) if params[:q] && !params[:q].empty?
    # Category filter
    @equipment = @equipment.filter_equipment(params[:equipments][:categories].downcase) if params[:equipments] && params[:equipments][:categories] != ""
  end
  
  def show
    @user = User.find(user_id)
    @equipment = [Equipment.find(equipment_id)]
  end

  def new
      @equipment = Equipment.new
  end

  def create
      @equipment = Equipment.new(equipment_params)
      @equipment.user_id = user_id

      if @equipment.save
        redirect_to user_equipment_index_path
      else
      render :new
      end
  end
  
  def edit
    @equipment = Equipment.find(equipment_id)

    if validate_user(user_id) || @equipment.user_id != user_id.to_i
      redirect_to root_path
    end
  end
  
  def update
    @equipment = Equipment.find(equipment_id)
    equipment_user_id = @equipment.user_id

      @equipment.categories.clear
      if @equipment.update(equipment_params)
        redirect_to user_equipment_index_path
      else
        render :update
      end
  end
  
  def destroy
    @equipment = Equipment.find(equipment_id)
    equipment_user_id = @equipment.user_id

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

  def user_id
    params[:user_id]
  end

  def equipment_id
    params[:id]
  end

  def equipment_params
    params.require(:equipment).permit(:name, :brand, :description, :pic_url, category_ids:[], categories_attributes: [:title])
  end
end
