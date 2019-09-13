class EquipmentController < ApplicationController
   before_action :authenticate_user!

  def index
    @user = current_user
  end
  
  def show
    @user = current_user
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
