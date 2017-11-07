class FeedbacksController < ApplicationController
	def new
		@feedback = Feedback.new()
	end
	def create
		@feedback = Feedback.new(feedback_params)
		@feedback.user_id = current_user.id
		@feedback.save
		render 'acknoledgement'
	end
	protected
	def feedback_params
		params.require(:feedback).permit(:body)
	end

	layout 'shop'
end