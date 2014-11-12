$(document).ready(function(){
	console.log('hello!');
	$.get('/events.json', function(events){
		var map = new GMaps({
			div: '#map',
			lat: 51.5260,
			lng: 0.0780,
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
})
