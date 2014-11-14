$(document).ready(function(){
	$.get('/events.json', function(events){
		var map = new GMaps({
			div: '#map',
			lat: 51.496401,
			lng: -0.142994,
			minZoom: 2,
			maxZoom: 16
		});
		for(var i = 0; i < events.length; i++) {
			map.setCenter(events[i].lat, events[i].lng);
			map.addMarker({
				lat: events[i].lat,
				lng: events[i].lng
			}); 
			map.fitZoom();
		}
	});

	$.get('/events/' + $('#map-individual').data('id') + '.json', function(event){
		if ($('#map-individual').length > 0) {
			console.log($('#map-individual').data('id'));
			var mapIndividual = new GMaps({
				div: '#map-individual',
				lat: 51.496401,
				lng: -0.142994,
				minZoom: 2,
				maxZoom: 16
			});
			mapIndividual.setCenter(event.lat, event.lng);
			mapIndividual.addMarker({
				lat: event.lat,
				lng: event.lng
			});
			mapIndividual.fitZoom();
		}
	});
})
