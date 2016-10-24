class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
private

	 def current_user
	 	#AUTHENTICATION FROM SCRATCH METHOD START
	 	# @current_user ||= User.find(session[:user_id]) if session[:user_id]
	 	#AUTHENTICATION FROM SCRATCH METHOD END

		@user = User.find_by(id: session[:user_id] )

	 	# @current_user = User.find_by(id: auth_hash[:id], provider: 'github') if session[:user_id]
	 end
end
