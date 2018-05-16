module ApplicationHelper

  def current_user
    User.find_by(id: session[:user_id])
  end

  def user_portfolio_id
    current_user.portfolio.id
  end

end
