$(function(){

  $(".new_portfolio_stock").on("submit", function(e){
    e.preventDefault();
    $.ajax({
      method: "POST",
      url: this.action
    }).success(function(response){
      debugger

    })


  }) // ends on click function

}) // ends anon function
