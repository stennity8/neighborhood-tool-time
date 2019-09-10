class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

      def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :street_address, :city, :state, :zip_code, :email, :password]) 
          devise_parameter_sanitizer.permit(:account_update, keys: [:name, :street_address, :city, :state, :zip_code, :email, :password, :current_password]) 
      end
end
