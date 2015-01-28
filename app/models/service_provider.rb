# == Schema Information
#
# Table name: service_providers
#
#  id               :integer          not null, primary key
#  first_name       :string
#  last_name        :string
#  gender           :integer
#  service          :string
#  years_experience :integer
#  phone            :string
#  address          :string
#  email            :string
#  password_hash    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  birthday         :date
#

class ServiceProvider < ActiveRecord::Base
  include BCrypt

  validates_uniqueness_of :email
  validates_presence_of :email, :password, :first_name, :last_name, :gender

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
    payload = { sp_id: self.id }
    AuthToken.encode(payload)
  end
end
