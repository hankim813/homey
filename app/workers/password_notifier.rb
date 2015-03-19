class PasswordNotifier
  include Sidekiq::Worker

  def perform(email, token)
    PasswordMailer.new_password_token(email, token).deliver_now
  end
end
