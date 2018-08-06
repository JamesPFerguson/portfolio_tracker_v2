$(function(){

  $(".grab-stocks").on("click", function(e){
    e.preventDefault();
    $.ajax({
      method: "GET",
      url: this.href,
      dataType: "json",
    }).success(function(r){
      r.forEach(function(j_stock){
        let stock = new Stock(j_stock.id, j_stock.ticker, j_stock.price)
        stockHtml = stock.formatStock();
        $(".all-stocks").append(stockHtml)
      }) //ends forEach
    }) // ends success
  }) // ends on click
}) //ends anon function

function Stock(id, ticker, price) {
  this.id = id
  this.ticker = ticker
  this.price = price
}

Stock.prototype.formatStock = function() {
  let stockHtml = '<tr>'
  stockHtml += `<td><a href="/stocks/${this.stock_id}">${this.ticker}</a> </td>`
  stockHtml += `<td>${this.price}</td>`
  stockHtml += "</tr>"
  return stockHtml
}
