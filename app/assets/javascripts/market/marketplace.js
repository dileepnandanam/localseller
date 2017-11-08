$(document).on('turbolinks:load', function(){
function init_place_search() {
	var input = document.getElementById('place')
	var autocomplete = new google.maps.places.Autocomplete(input, { types: ['geocode'] })
	$('.search_button').on('click', function(e){
		$('#geolocation').val(autocomplete.getPlace().geometry.location)
	})
}
//google.maps.event.addDomListener(window, 'load', init_place_search);
setTimeout(function(){init_place_search()}, 3000)
})
$(document).on('turbolinks:load', function(){
	$('.search-form').on('ajax:success', function(e, data, status, xhr){
		build_results(data)
	})
	
		setTimeout(function(){
		if($('#geolocation').length == 1){
			$.ajax({
				dataType: 'json',
				url: '/initial_results',
				data: {
					geolocation: $('#geolocation').val()
				},
				success: function(data){
					build_results(data)
				}

			})
		}}, 3000)
})
function build_results(data) {
	map_center = $('#geolocation').val().substring(1,$('#geolocation').val().length-1).split(', ')
	map_center = {lat: parseFloat(map_center[0]), lng: parseFloat(map_center[1])}
	 var map = new google.maps.Map(document.getElementById('map'), {
		zoom: 9,
		center: map_center
	});
	current_product = []
	$('.results-body > .result-item').remove()
	$.each(data, function(index, product){
		item = $('.results-body').append(
			
			"<div class=\'result-item\' data-lat='" + product.lat +"\' data-lng=\'" + product.lng + "'> <div class=\'result-item-value pull-left\'>" + product.name + "</div> <div class=\'result-item-value pull-left\'>" + product.distance + " Km" + "</div><div class=\'result-item-value pull-left\'>" + product.price + "</div> <div class=\'result-item-value pull-left\'>" + product.total + "</div><div class=\'clearfix\'></div></div>"
			
		)
		var marker = new google.maps.Circle({
        	strokeColor: '#FF0000',
        	strokeOpacity: 0.8,
        	strokeWeight: 2,
        	fillColor: '#FF0000',
        	fillOpacity: 0.35,
        	map: map,
        	center: {lat: product.lat, lng: product.lng},
        	radius: 2500
    	});

		current_product[index] = $(item).children().last()
    	marker.addListener('mouseover', function(){
    		current_product[index].addClass('current')
    	})
    	marker.addListener('mouseout', function(){
    		current_product[index].removeClass('current')
    	})
    	$(current_product[index]).mouseenter(function(){
    		marker.setRadius(5000)
    		map.setCenter({lat: product.lat, lng: product.lng})
    	})
    	$(current_product[index]).mouseout(function(){
    		marker.setRadius(2500)
    	})
		



	})
}