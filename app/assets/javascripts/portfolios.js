$(document).ready(function() {
  $("#price-sort").on("click", sortPortfolioStocks)
})

function sortPortfolioStocks (e) {
  e.preventDefault();
  $.ajax({
    method: "GET",
    url: this.href,
    dataType: "json"
  }).success(function(r){
    debugger
    let p_value = r.value
    port_stocks = r.portfolio_stocks.map(p_stock => {
      return new PortfolioStock(p_stock.id, p_stock.ticker, p_stock.stock_id, p_stock.portfolio_id, p_stock.quantity)
    })
    port_stocks.sort(function (a, b) {
      return a.quantity < b.quantity;
    })
    $(".stock-tr").remove()
    port_stocks.forEach(p_stock => {
      let stock_html = p_stock.formatPortfolioStock()
      $(".portfolio-stocks-home-table").append(stock_html)
    })
  })
}
