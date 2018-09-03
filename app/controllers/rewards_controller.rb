class RewardsController < ApplicationController
  def index
    if current_user
      if current_user.role == 1
        @rewards = Reward.all
        render :adminindex
      else
        @rewards = Reward.all
        @user = current_user
      end
    else
      redirect_to root_path
      flash[:notice] = 'You must be an logged in to access this page.'
    end
  end

  def new
    if current_user.role == 1
      @reward = Reward.new
    else
      redirect_to root_path
      flash[:notice] = 'You must be an admin to access this page.'
    end
  end

  def create
    @reward = Reward.new(reward_params)
    if @reward.save
      # If user saves in the db successfully:
      redirect_to rewards_path
      flash[:notice] = "Account created successfully!"
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
      render :new
    end
  end

  private

  def reward_params
    params.require(:reward).permit(:title, :price)
  end
end
