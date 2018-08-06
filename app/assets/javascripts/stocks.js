$(function(){

  $(".grab-stocks").on("click", function(e){
    e.preventDefault();
    $.ajax({
      method: "GET",
      url: this.action,
      dataType: "json"
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


$(function(){

  $(".next-stock-form").on("submit", function(e){
    e.preventDefault()
    $.ajax({
      method: "POST",
      url: this.action,
      dataType: "json",
      data: $(this).serialize()
    }).success(function(r){
      let showStock = new ShowStock(r.id, r.name, r.ticker, r.price, r.market_cap_string, r.pe_ratio, r.six_month_appreciation)
      $("next-stock-id").attr("id", 3)
    }) // ends success
  }) // ends on click
})


function ShowStock(id, name, ticker, price, market_cap_string,
   pe_ratio, six_month_appreciation) {
  this.id = id
  this.ticker = ticker
  this.price = price
  this.market_cap = market_cap_string
  this.pe_ratio = pe_ratio
  this.six_month = six_month_appreciation
}

// ShowStock.prototype.formatShowStock = function() {
//   let showHtml = ''
//
// }
