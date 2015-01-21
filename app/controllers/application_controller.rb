class ApplicationController < ActionController::API
	before_action :authenticate_request

	rescue_from NotAuthenticatedError do
		render json: { error: 'Not Authorized' }, status: :unauthorized
	end

	rescue_from AuthenticationTimeoutError do
		render json: { error: 'Auth Token Is Expired' }, status: 419
	end

	private

		def set_current_user
			@current_user ||= User.find(@decoded_auth_token[:user_id])
		end

		def authenticate_request
			if auth_token_expired?
				fail AuthenticationTimeoutError
			elsif !set_current_user
				fail NotAuthenticatedError
			end
		end

		def decoded_auth_token
			@decoded_auth_token ||= AuthToken.decode(http_auth_header_content)
		end

		def auth_token_expired?
			decoded_auth_token && decoded_auth_token.expired?
		end

		def http_auth_header_content
			return @http_auth_header_content if defined?(@http_auth_header_content)
			@http_auth_header_content = begin
				if request.headers['Authorization'].present?
					request.headers['Authorization'].split(' ').last
				else
					nil
				end
			end
		end
end
