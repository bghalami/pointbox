class UsersController < ApplicationController

  def new
    if current_user
      if current_user.role == 1
        @user = User.new
      else
        redirect_to root_path
        flash[:notice] = 'You must be an admin to access this page.'
      end
    else
      redirect_to root_path
      flash[:notice] = 'You must be an admin to access this page.'
    end
  end

  def adminshow
    if current_user.role == 1
      @user = User.find(params[:id])
    else
      redirect_to root_path
      flash[:notice] = 'You must be an admin to access this page.'
    end
  end

  def index
    if current_user.role == 1
      @users = User.all.order(id: :asc)
    else
      redirect_to root_path
      flash[:notice] = 'You must be an admin to access this page.'
    end
  end

  def create
    @user = User.new(user_params)
    # store all usernames in lowercase to avoid duplicates
    # and case-sensitive login errors:
    @user.username.downcase!

    if @user.save
      # If user saves in the db successfully:
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
      render :new
    end
  end

  def gamble
    @user = current_user
    
  end

  def edit
    # require 'pry'; binding.pry
    if current_user.role == 1
      @user = User.find(params[:id])
    else
      redirect_to root_path
      flash[:notice] = 'You must be an admin to access this page.'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      # If user saves in the db successfully:
      flash[:notice] = "Account updated successfully!"
      redirect_to update_users_path(@user)
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = "Oops, couldn't save updates. Please make sure you are using valid info and try again."
      render :edit
    end
  end

  def buyreward
    # require 'pry'; binding.pry
    user = current_user
    reward = Reward.find(params[:id])
    if user.points > reward.price
      user.points -= reward.price
      user.rewards << reward
      user.redeemed_points += reward.price
      user.save
      redirect_to root_path
    else
      redirect_to rewards_path
      flash[:notice] = "Not enough points to buy! Pick a cheaper prize you bum!"
    end
  end

  def removereward

  end

  def destroy
    user = User.find(params[:id])
    user.delete

    redirect_to all_users_path
    flash[:notice] = "User #{user.name} has been deleted."
  end

  private

  def user_params
    # strong parameters -
    # whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a
    # form to the user model #=> require(:user)
    params.require(:user).permit(:name, :username, :password, :points, :redeemed_points, :password_confirmation, :role)
  end

end
