module ApplicationHelper
  def validate_user(user_id)
    if current_user.id != user_id.to_i
      flash[:danger] = "You are not authorized to perform that action."
      redirect_to root_path
    end
  end
end
