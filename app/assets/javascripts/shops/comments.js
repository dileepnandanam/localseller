$(document).on('turbolinks:load', function(){

	$('#new_comment').on("ajax:success", function(e, data, status, xhr){
		$('.automated-feedback').html(xhr.responseText)
		$('#comment_text').val('')
	})

})