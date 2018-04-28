class UsersController < ApplicationController

  def new
  end

  def create
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
