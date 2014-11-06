json.array! @events.each do |event|
	json.title event.title
	json.address event.address
	json.city event.city
	json.postcode event.postcode
end