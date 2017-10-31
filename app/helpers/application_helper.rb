module ApplicationHelper

	def time_for_fetch_location
		return true
		if session[:location_fetched_at] && Time.parse(session[:location_fetched_at]) + 24.hours <= Time.now || session[:location_fetched_at].nil? || session[:lat].nil? || current_user && current_user.lat.nil?
			session[:location_fetched_at] = Time.now
			return true
		end
	end
end
