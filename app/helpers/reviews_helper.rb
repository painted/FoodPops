module ReviewsHelper
	def star_rating(rating)
		return rating unless rating.respond_to?(:round)

		rounded_rating = rating.round
		remainder = (6 - rounded_rating)
		if remainder == 0
			("★" * rounded_rating)
		else
			("★" * rounded_rating) + ('☆' * (remainder - 1))
		end
	end
end
