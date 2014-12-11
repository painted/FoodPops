json.array! @users.each do |foody|
	json.username foody.username
	json.avatar.url foody.avatar
end