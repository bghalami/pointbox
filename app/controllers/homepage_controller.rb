class HomepageController < ApplicationController
  def show
    if current_user
      redirect_to user_path(current_user)
    end
    redirect_to login_path
  end
end
