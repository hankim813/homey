ActionMailer::Base.smtp_settings = {
	address: 'smtp.mandrillapp.com',
	port: 587,
	enable_starttls_auto: true,
	user_name: 'hankim813@gmail.com',
	password: 'to82xtOxNG57nuX6eeZq-Q',
	authentication: 'login'
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: 'utf-8'