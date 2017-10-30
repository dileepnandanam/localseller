function init_place_search() {
	var input = document.getElementById('place')
	var autocomplete = new google.maps.places.Autocomplete(input, { types: ['geocode'] })
	$('.search_button').on('click', function(e){
		$('#geolocation').val(autocomplete.getPlace().geometry.location)
	})
}
//google.maps.event.addDomListener(window, 'load', init_place_search);
$(document).on('turbolinks:load', function(){
init_place_search()
})
$(document).on('turbolinks:load', function(){
	$('.search-form').on('ajax:success', function(e, data, status, xhr){
		map_center = $('#geolocation').val().substring(1,$('#geolocation').val().length-1).split(', ')
		map_center = {lat: parseFloat(map_center[0]), lng: parseFloat(map_center[1])}
		 var map = new google.maps.Map(document.getElementById('map'), {
    		zoom: 7,
    		center: map_center
  		});

		$('.results-body > .result-item').remove()
		$.each(data, function(index, product){
			item = $('.results-body').append(
				`
				<div class="result-item" data-lat='${product.lat}' data-lng='${product.lng}'>
				  <div class="result-item-value pull-left">
				    ${product.name}
				  </div>
				  <div class="result-item-value pull-left">
				    ${product.distance + " Km"} 
				  </div>
				  <div class="result-item-value pull-left">
				    ${product.price}
				  </div>
				  <div class="result-item-value pull-left">
				    ${product.total}
				  </div>
				  <div class="clearfix"></div>
				</div>
				`
			)
			var marker = new google.maps.Circle({
            	strokeColor: '#FF0000',
            	strokeOpacity: 0.8,
            	strokeWeight: 2,
            	fillColor: '#FF0000',
            	fillOpacity: 0.35,
            	map: map,
            	center: {lat: product.lat, lng: product.lng},
            	radius: 10000
        	});

        	marker.addListener('mouseover', function(){
        		$(item).children().last().addClass('current')
        	})
        	marker.addListener('mouseout', function(){
        		$(item).children().last().removeClass('current')
        	})

			



		})
	})
})