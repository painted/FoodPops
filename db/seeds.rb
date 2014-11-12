# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

content = open("https://www.eventbriteapi.com/v3/events/search/?categories=110&token=#{Rails.application.secrets.eventbrite_token}").read

hash = JSON.parse content

eventbrite = Foody.create email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'EventBrite'

hash["events"][1..10].each do |event|
	title = event['name']['text']
	description = event['description']['text']
	start_date = DateTime.strptime event['start']['utc']
	end_date = DateTime.strptime event['end']['utc']
	address = event['venue']['address']['address_1']
	city = event['venue']['address']['city']
	postcode = event['venue']['address']['postal_code']
	eventbrite.events.create(title: title, description: description, start_date: start_date, end_date: end_date, address: address, city: city, postcode: postcode)
end
