class AuthToken 
	def self.encode(payload, exp=72.hours.from_now)
		payload[:exp] = exp.to_i
		p 'SECRET KEY BASE'
		p Rails.application.secrets.secret_key_base
		p 'PAYLOAD INSIDE TOKEN'
		p payload
		JWT.encode(payload, Rails.application.secrets.secret_key_base)
	end

	def self.decode(token)
		payload = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
		DecodedAuthToken.new(payload)
		rescue
			nil
	end
end

class DecodedAuthToken < HashWithIndifferentAccess
	def expired?
		self[:exp] <= Time.now.to_i
	end	
end