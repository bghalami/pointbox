class HomepageController < ApplicationController
  def show
    if current_user
      redirect_to users_dashboard_path
    else
      redirect_to login_path
    end
  end
end
