module ApplicationHelper

  def current_user
    User.find_by(id: session[:user_id])
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
