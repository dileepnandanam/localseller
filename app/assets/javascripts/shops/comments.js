$(document).on('turbolinks:load', function(){

	$('.new_comment, .reply-form').on("ajax:success", function(e, data, status, xhr){
		$(this).closest('.comment-form').siblings('.comments-container').prepend(xhr.responseText)
		$(this).find('#comment_text').val('')

	})
	$('.show-reply-form').on('click', function(e){
		e.preventDefault();
		$(this).siblings('.comment-form').toggle()
	})

})
