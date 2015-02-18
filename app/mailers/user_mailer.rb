class UserMailer < ApplicationMailer
	default from: "no-reply@homey.com"

	def new_user(user)
		@user = user
		mail(
			to: "#{@user.first_name} <#{@user.email}>",
			subject: "Welcome to Homey, #{@user.first_name}!" 
		) do |format|
			format.html { render layout: @new_user }
		end
	end

end
