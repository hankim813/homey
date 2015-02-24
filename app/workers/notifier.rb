class	Notifier
	include Sidekiq::Worker

	def perform(name, email)
		UserMailer.new_user(name, email).deliver_now
	end
end