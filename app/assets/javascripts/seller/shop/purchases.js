$(document).on('turbolinks:load', function() {
   $('.mark-as-shipped').on('ajax:success', function(){
		$(this).closest('tr').remove()
	})
});

