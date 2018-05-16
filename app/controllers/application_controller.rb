class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper :all
  protect_from_forgery with: :exception
  before_action :require_login


    def current_user
      User.find_by(id: session[:user_id])
    end

    def set_user
      @user = current_user
    end

    def get_user_id
      current_user.id
    end
end
