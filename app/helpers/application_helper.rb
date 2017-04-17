module ApplicationHelper

	def time_for_fetch_location
		if session[:location_fetched_at] && Time.parse(session[:location_fetched_at]) + 24.hours <= Time.now || session[:location_fetched_at].nil?
			session[:location_fetched_at] = Time.now
			return true
		end
	end
end
