$(document).ready(function() {
  attachListener();
})

function attachListener() {
  $(".new_portfolio_stock").on("submit", addStock)
}

function addStock (e) {

    e.preventDefault();
    $.ajax({
      method: "POST",
      url: this.action,
      dataType: "json",
      data: $(this).serialize()
    }).success(function(r){
      let pStock = new PortfolioStock(r.id, r.ticker, r.stock_id, r.portfolio_id, r.quantity)
      stockHtml = pStock.formatPortfolioStock();
      $(".portfolio-stocks").append(stockHtml)
    })


  }

function PortfolioStock(id, ticker, stock_id, portfolio_id, quantity) {
  this.id = id
  this.ticker = ticker
  this.stock_id = stock_id
  this.portfolio_id = portfolio_id
  this.quantity = quantity
}

PortfolioStock.prototype.formatPortfolioStock = function () {
  let pStockHtml = ''
  pStockHtml += "<tr class='js-portfolio-stock-row'>"
  pStockHtml += `<td><a href="/stocks/${this.stock_id}">${this.ticker}</a> </td>`
  pStockHtml += `<td> ${this.quantity} </td>`
  pStockHtml += `<td><a href="/portfolios/${this.portfolio_id}/portfolio_stocks/${this.id}/edit">Edit quantity</a> </td>`
  pStockHtml += "</tr>"
  return pStockHtml;
}
