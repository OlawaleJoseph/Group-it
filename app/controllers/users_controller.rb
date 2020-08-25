class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:author_id] = @user.id
      flash[:success] = "Welcome to Group-It #{@user.username}"
      redirect_to root_path
    else
      flash[:error] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
