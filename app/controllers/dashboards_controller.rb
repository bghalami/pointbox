class DashboardsController < ApplicationController
  def show
    if current_user.role == 1
      redirect_to admin_path
    else
      @user = current_user
    end
  end
end
