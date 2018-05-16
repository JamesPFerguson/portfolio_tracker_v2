class StaticController < ApplicationController

  skip_before_action :require_login, only: [:missing, :home]
  before_action :redirect_to_portfolio, only: :home

  def missing

  end

  def home

  end

end
