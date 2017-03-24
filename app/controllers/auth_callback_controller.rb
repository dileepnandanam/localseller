class AuthCallbackController < ApplicationController
	def callback
		auth_hash = AuthHandler.create_authentication(request.env['omniauth.auth'])
		
		if auth_hash.user
			sign_in(auth_hash.user)
			redirect_to root_path
		else
			session[:social_auth] = auth_hash.id
			redirect_to  new_user_registration_path 
		end
	end
end
