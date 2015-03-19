class PasswordMailer < ApplicationMailer
  default from: "Homey <no-reply@homey.com>"

  def new_password_token(email,token)
    @email = email
    @token = token
    mail(
      to: "samantha.stallings1@gmail.com",
      subject: "Your password reset token from 'Homey!"
    ) do |format|
      format.html { render layout: @new_password_message }
    end
  end
end