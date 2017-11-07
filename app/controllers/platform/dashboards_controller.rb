class Platform::DashboardsController < ApplicationController
	def feedbacks
		@feedbacks = Feedback.order('created_at DESC')
	end
	layout 'platform'
end