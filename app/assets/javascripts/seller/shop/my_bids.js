$(document).on('turbolinks:load', function() {
   $('.delete-bid').on('ajax:success', function(){
		$(this).closest('.bid-item').hide(500)
	})
});
