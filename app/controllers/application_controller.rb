class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper: all
  protect_from_forgery with: :exception

    def current_user
      User.find_by(id: session[:user_id])
    end

    def set_user
      @user = current_user
    end

    def get_portfolio_id
      current_user.portfolio.id
    end
end
