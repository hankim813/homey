class UsersController < ApplicationController
	before_filter :allow_access_to_client

	def index
		render json: User.all
	end

	private
		def allow_access_to_client
			headers['Access-Control-Allow-Origin'] = '*'
			headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
			headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
		end
end
