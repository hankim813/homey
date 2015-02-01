# == Schema Information
#
# Table name: admins
#
#  id                  :integer          not null, primary key
#  first_name          :string
#  last_name           :string
#  gender              :integer
#  email               :string
#  phone               :string
#  authorization_level :integer
#  password_hash       :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  birthday            :date
#

class Admin < ActiveRecord::Base
  has_many :discounts
  
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
  def generate_auth_token_admin
    payload = { admin_id: self.id }
    AuthToken.encode(payload)
  end
end
