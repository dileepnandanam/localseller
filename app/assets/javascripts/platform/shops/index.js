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
});

