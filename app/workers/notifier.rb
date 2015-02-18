class	Notifier
	include Sidekiq::Worker

	def perform(email)
		puts 'sending email....'
	end
end