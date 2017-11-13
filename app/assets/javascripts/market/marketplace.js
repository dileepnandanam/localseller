
var current_page = 1
var results_per_page
var map
var markers = []
var getInitialResult = function(){
	map = initMap()
	$.ajax({
		dataType: 'json',
		url: '/initial_results',
		data: {
			geolocation: toMarkerTuple(mapParams().center)
		},
		success: function(data){
			clearResults()
			build_results(data)
			showPaginationLink(data, results_per_page)
		}

	})
		
}
function build_results(data) {
	$('.results-wait').hide()
	
	current_product = []
	$.each(data, function(index, product){
		item = $('.results-body').append(
			
			"<div class=\'result-item\' data-lat='" + product.lat +"\' data-lng=\'" + product.lng + "'> <div class=\'result-item-value pull-left\'>" + product.name + "</div> <div class=\'result-item-value pull-left\'>" + product.distance + " Km" + "</div><div class=\'result-item-value pull-left\'>" + product.price + "</div> <div class=\'result-item-value pull-left\'>" + product.total + "</div><div class=\'clearfix\'></div></div>"
			
		)
		$('.result-grid-view > .clearfix').remove()
		item_grid = $('.result-grid-view').append(

			"<div class=\'result-item-grid-wraper  col-lg-4 col-md-6 col-xs-1\'> <div class=\'result-item-grid\'><div class=\'result-item-grid-name\'> Item </div><div class=\'result-item-grid-value\'>" + product.name + "</div><div class=\'result-item-grid-name\'> Distance </div><div class=\'result-item-grid-value\'>" + product.distance + " Km" + "</div><div class=\'result-item-grid-name\'> Rate (Per Kg) </div> <div class=\'result-item-grid-value\'>" + product.price + "</div><div class=\'result-item-grid-name\'> Total </div><div class=\'result-item-grid-value\'>" + product.total + "</div></div></div>"
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

    	markers.push(marker)

		current_product[index] ={row: $(item).children().last(), grid: $(item_grid).children().last().find('.result-item-grid')}
    	marker.addListener('mouseover', function(){
    		current_product[index].row.addClass('current')
    		current_product[index].grid.addClass('current')
    	})
    	marker.addListener('mouseout', function(){
    		current_product[index].row.removeClass('current')
    		current_product[index].grid.removeClass('current')
    	})
    	$(current_product[index].row).mouseenter(function(){
    		marker.setRadius(5000)
    		map.setCenter({lat: product.lat, lng: product.lng})
    	})
    	$(current_product[index].grid.children()).mouseenter(function(){
    		marker.setRadius(5000)
    		map.setCenter({lat: product.lat, lng: product.lng})
    	})
    	$(current_product[index].row).mouseout(function(){
    		marker.setRadius(2500)
    	})
    	$(current_product[index].grid.children()).mouseout(function(){
    		marker.setRadius(2500)
    	})
    	$('.result-grid-view').append("<div class=\'clearfix\'> <div>")
	})
}

$(document).on('turbolinks:load', function(){
	results_per_page = $('.results-body').data('results-per-page')

	function init_place_search() {
		var input = document.getElementById('place')
		var autocomplete = new google.maps.places.Autocomplete(input, { types: ['geocode'] })
		$('.search_button').on('click', function(e){
			$('#geolocation').val(autocomplete.getPlace().geometry.location)
		})
	}
	//google.maps.event.addDomListener(window, 'load', init_place_search);
	setTimeout(function(){init_place_search()}, 3000)




	$('.search-form').on('ajax:success', function(e, data, status, xhr){
		clearResults()
		build_results(data)
		showPaginationLink(data, results_per_page)
	})

	$('.load-more-button').on('click', function(){
		$.ajax({
			data: {
				geolocation: toMarkerTuple(mapParams().center),
				term: $('#term').val(),
				quantity: $('#quantity').val(),
				page: ++current_page
			},
			dataType: 'json',
			url: '/search',
			success: function(data) {
				build_results(data)
				showPaginationLink(data, results_per_page)
			}
		})
	})

	$('.filter-grid').on('click', function(){
		$('.result-grid-view').show()
		$('.result-row-view').hide()
		$(this).addClass('current-filter')
		$('.filter-row').removeClass('current-filter')
	})
	$('.filter-row').on('click', function(){
		$('.result-grid-view').hide()
		$('.result-row-view').show()
		$(this).addClass('current-filter')
		$('.filter-grid').removeClass('current-filter')
	})

	
	setTimeout(function(){getInitialResult()}, 3000)
})
mapParams = function(){
	if($('#geolocation').val().length > 4){
		map_center = $('#geolocation').val().substring(1,$('#geolocation').val().length-1).split(', ')
		map_center = {lat: parseFloat(map_center[0]), lng: parseFloat(map_center[1])}
		return({
			zoom: 9,
			center: map_center
		})
	} else {
		return({
			center: {lat: 10.8505159, lng: 76.27108329999999},
			zoom: 6 
		})
	}
}
initMap = function(){
	var new_map = new google.maps.Map(document.getElementById('map'), mapParams());
	return(new_map)
}
clearResults = function(){
	$('.results-body > .result-item').remove()
	$('.result-grid-view > .result-item-grid-wraper').remove()
	for (var i = 0; i < markers.length; i++) {
    	markers[i].setMap(null);
    }
}
toMarkerTuple = function(marker){
	return(
		"(" + marker.lat + ", " + marker.lng + ")"
	)
}
showPaginationLink = function(data, results_per_page) {
	if(data.length < results_per_page)
		$('.load-more-button').hide()
	else
		$('.load-more-button').show()
}
