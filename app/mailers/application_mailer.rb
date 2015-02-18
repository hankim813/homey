class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@homey.com"
  layout 'mailer'
end
