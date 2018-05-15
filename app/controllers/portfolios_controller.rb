class PortfoliosController < ApplicationController

  def show
    @portfolio = Portfolio.find_by(id: params[:id])
  end

end
