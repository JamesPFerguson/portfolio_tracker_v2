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
      let showStock = new ShowStock(r.id, r.name, r.ticker, r.price,
         r.market_cap_string, r.pe_ratio, r.six_month_appreciation)
      $(".stock-name").html(showStock.name)
      $(".stock-ticker").html(showStock.ticker)
      $(".stock-price").html(showStock.price)
      $(".market-cap").html(showStock.market_cap_string)
      $(".pe-ratio").html(showStock.pe_ratio)
      $(".six-month").html(showStock.six_month_appreciation)

      nextId = parseInt(r.id) + 1
      $(".next-stock-id").val(nextId)
    }) // ends success
  }) // ends on click
})


function ShowStock(id, name, ticker, price, market_cap_string,
   pe_ratio, six_month_appreciation) {
  this.id = id
  this.name = name
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
