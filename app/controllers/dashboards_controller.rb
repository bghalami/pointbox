class DashboardsController < ApplicationController
  def show
    if current_user.role == 1
      redirect_to admin_path
    else
      @user = current_user
    end
  end

  def update
    risk_array = [0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0.2, 0.2, 1, 1, 5, 10, 50]
    user = current_user
    risk = user_params[:points].to_i
    user.points -= risk
    new_value = (risk * risk_array.sample).to_i
    user.points += new_value
    user.save
    redirect_to gamblers_path
    flash[:notice] = "You risked #{risk} points, and have won #{new_value} points!"
  end

  private

  def user_params
    params.require(:user).permit(:points)
  end
end
