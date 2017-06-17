$(document).on('turbolinks:load', function() {
   $('.platform-shop-search-field').keyup(function(e){
   		$.ajax({
   			type: 'get',
   			url: $('.all-shops').data('search-path'),
   			data: {query: $(".platform-shop-search-field").val()}

   		}).success(function(data){
   			$('.search-result').html(data)
   		})
   })




	$('.search-users').keyup(function(e){
   		$.ajax({
   			type: 'get',
   			url: $('.platform-users').data('search-path'),
   			data: {query: $(".search-users").val()}

   		}).success(function(data){
   			$('.users-table').html(data)
   		})
   })   
});

