# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

$(function(){

  $("new_portfolio_stock").on("click", function(e){

    $.ajax({
      method: "POST"
      url = 'this.href'
    }).success(function(response){
      
      
    })

    e.preventDefault();
  }) // ends on click function
  
}) // ends anon function