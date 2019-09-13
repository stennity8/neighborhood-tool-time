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
  end
  
  def edit
  end

  def update
  end

  def destroy
  end

  private 

  def equipment_params
    params.require(:equipment).permit(:name, :password, :nausea_rating, :happiness_rating, :tickets, :min_height)
  end
end
