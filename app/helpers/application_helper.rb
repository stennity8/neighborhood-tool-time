module ApplicationHelper
  def validate_user(user_id)
    if current_user.id != user_id
      flash[:danger] = "You are not authorized to perform that action."
    end
  end
end
