class AuthController < ApplicationController
	skip_before_action :authenticate_request

	def authenticate
		user = User.find_by(email: params[:email])
    sp = ServiceProvider.find_by(email: params[:email])

		if user
			render json: { auth_token: user.generate_auth_token }
    elsif sp
      render json: { auth_token: sp.generate_auth_token_sp }
		else
			render json: { error: 'Invalid username or password' }, status: :unauthorized
		end
	end
end