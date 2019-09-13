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
    @equipment = []
    @equipment << Equipment.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
