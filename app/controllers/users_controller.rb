class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
    else
      render 'new'
    end
    portfolio = Portfolio.create
    portfolio.user = @user
    redirect_to portfolio_path(portfolio)
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
