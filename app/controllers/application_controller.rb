class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	
#	rotect_from_forgery with: :exception
#	helper_method :current_user
	helper_method :current_account
	
	
	private

	def current_account
		#@current_user ||= User.find(session[:user_id]) if session[:user_id]
		@current_account ||= Account.find(session[:account_id]) if session[:account_id]

	end


=begin
	def current_fbuser
		@current_fbuser ||= Fbuser.find(session[:fbuser_id]) if session[:fbuser_id]
	end
=end
end
