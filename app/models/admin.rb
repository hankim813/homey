class Admin < ActiveRecord::Base
  include BCrypt

  validates_uniqueness_of :email
  validates_presence_of :email, :password, :first_name, :last_name

  # Password Hashing
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(pass)
    self.password == pass
  end

  # Token Auth
  def generate_auth_token_sp
    payload = { admin_id: self.id }
    AuthToken.encode(payload)
  end
end