class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  before_action :redirect_to_portfolio, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      portfolio = Portfolio.create
      portfolio.user = current_user
      portfolio.save
      redirect_to portfolio_path(portfolio)
    else
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
