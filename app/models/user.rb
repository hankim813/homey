# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  first_name    :string
#  last_name     :string
#  gender        :integer
#  email         :string
#  phone         :string
#  password_hash :string
#  birthday      :date
#

class User < ActiveRecord::Base
	has_many :appointments
	has_many :redemptions
	has_many :bookings, through: :appointments

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
	def generate_auth_token
		payload = { user_id: self.id }
		p 'PAYLOADDDDDD'
		p payload
		AuthToken.encode(payload)
	end
end
