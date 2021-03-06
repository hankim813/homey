class AdminMailer < ApplicationMailer

	def new_contact_message(name, email, mood, message)
		@name = name
		@email = email
		@mood = mood
		@message = message
		mail(
			to: "emuli1@babson.edu",
			from: "#{name} <#{email}>",
			subject: "#{name} has a message for Homey!" 
		) do |format|
			format.html { render layout: @new_contact_message }
		end
	end
end
