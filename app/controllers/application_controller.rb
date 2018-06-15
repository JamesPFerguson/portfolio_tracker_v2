class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper :all
  before_action :require_login

  protect_from_forgery with: :exception
  # before_action :require_login


    def current_user
      User.find_by(id: session[:user_id])
    end

    def set_user
      @user = current_user
    end

    def get_user_id
        current_user.id
    end

    def user_portfolio_id
        current_user.portfolio.id
    end

    def signed_in?
      !!session[:user_id]
    end

    def require_login

      if !signed_in?
        flash[:notice] = "You must be logged in to access this page"
        redirect_to home_path
      end

    end

    def redirect_to_portfolio

      if signed_in?
        redirect_to portfolio_path(user_portfolio_id)
      end

    end

end
