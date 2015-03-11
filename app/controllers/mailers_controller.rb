class MailersController < ApplicationController
	skip_before_action :authenticate_request

	def contact
		ContactMailer.perform_async(params[:name], params[:email], params[:mood], params[:message])
	end
end
