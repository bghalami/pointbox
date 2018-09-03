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

  def show
    redirect_to rewards_path
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

  def edit
    @reward = Reward.find(params[:id])
  end

  def update
    @reward = Reward.find(params[:id])
    @reward.update(reward_params)
    if @reward.save
      # If reward saves in the db successfully:
      redirect_to rewards_path
      flash[:notice] = "Reward updated successfully!"
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = "Oops, couldn't save updates. Please make sure you are using valid info and try again."
      render :edit
    end
  end

  def disable
    reward = Reward.find(params[:id])
    reward.disabled = 1
    reward.save

    redirect_to rewards_path
    flash[:notice] = "Reward #{reward.title} has been disabled."
  end

  def enable
    reward = Reward.find(params[:id])
    reward.disabled = 0
    reward.save

    redirect_to rewards_path
    flash[:notice] = "Reward #{reward.title} has been enabled."
  end

  private

  def reward_params
    params.require(:reward).permit(:title, :price)
  end
end
