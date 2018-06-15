class PortfolioStock < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio
  accepts_nested_attributes_for :stock

  validates :quantity, :numericality => { :greater_than_or_equal_to => 1 }

  def ticker
    self.stock.ticker
  end

end
