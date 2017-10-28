function init_place_search() {
	var input = document.getElementById('place')
	var autocomplete = new google.maps.places.Autocomplete(input, { types: ['geocode'] })
	$('.search_button').on('click', function(e){
		e.preventDefault()
		$('#geolocation').val(autocomplete.getPlace().geometry.location)
		$(this).closest('form').submit()
	})
}
google.maps.event.addDomListener(window, 'load', init_place_search);