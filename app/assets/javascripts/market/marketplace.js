function init_place_search() {
	var input = document.getElementById('place')
	var autocomplete = new google.maps.places.Autocomplete(input, { types: ['geocode'] })
	$('.search_button').on('click', function(e){
		$('#geolocation').val(autocomplete.getPlace().geometry.location)
	})
}
google.maps.event.addDomListener(window, 'load', init_place_search);


				
var data1={}
$(document).on('turbolinks:load', function(){
	$('.search-form').on('ajax:success', function(e, data, status, xhr){
		$('.results-body > .result-item').remove()
		$.each(data, function(index, product){
			$('.results-body').append(
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

		})
	})
})