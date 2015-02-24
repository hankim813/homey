class UserMailer < ApplicationMailer
	default from: "Homey <no-reply@homey.com>"

	def new_user(name, email)
		@name = name
		@email = email
		mail(
			to: "#{name} <#{email}>",
			subject: "Welcome to Homey, #{name}!" 
		) do |format|
			format.html { render layout: @new_user }
		end
	end

end
