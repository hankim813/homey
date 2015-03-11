class	ContactMailer
	include Sidekiq::Worker

	def perform(name, email, mood, message)
		AdminMailer.new_contact_message(name, email, mood, message).deliver_now
	end
end