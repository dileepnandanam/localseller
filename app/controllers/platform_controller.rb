class PlatformController < ApplicationController
  before_action :authenticate_admin
  layout 'platform'

  protected
  def authenticate_admin
  	if current_user && current_user.usertype == 'admin' || controller_name == 'bills' && action_name =="payed"
  		true
  	else
  		redirect_to root_path
  	end
  end
end