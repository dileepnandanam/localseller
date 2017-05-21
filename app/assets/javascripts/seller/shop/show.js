$(document).on('turbolinks:load', function(){
	$('.search-comments').keyup(function(){
		$.ajax({
			data: {query: $(this).val()},
			type: 'get',
			url: $(this).data('search-url'),
			success: function(data){
				$('.comment-search-results').html(data)
			}
		})
	})
})