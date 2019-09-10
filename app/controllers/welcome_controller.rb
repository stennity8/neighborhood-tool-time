class WelcomeController < ApplicationController 
  # before_action :authenticate_user!

  def index
      @user = current_user if current_user
  end
end