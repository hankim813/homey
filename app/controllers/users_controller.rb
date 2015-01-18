class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: [:create, :find] 

	def index
		render json: User.all
	end

	def find
		user = User.find_by(email: params[:email])

		if user && user.authenticate(params[:password])
			render json: {
				token: user.generate_auth_token,
				user:  user.id
			}
		else
			render json: { error: 'Invalid Username or Password' }, status: 400
		end
	end

	def show
		render json: {
			user: {
				name: 		@current_user.first_name + " " + @current_user.last_name,
				email: 		@current_user.email,
				gender: 	@current_user.gender == 0 ? 'Male' : 'Female',
				age: 			@current_user.age,
				phone: 		@current_user.phone
			}
		}
	end

	def create
		userData = {
			email: params[:email], 
			password: params[:password],
			first_name: params[:firstName],
			last_name: params[:lastName],
			gender: params[:gender].to_i,
			age: params[:age].to_i,
			phone: params[:phone]
		}
		p userData
		user = User.new(userData)

		if user.save
			render json: { 
				token: user.generate_auth_token,
				user: user.id 
			}
		else
			render json: { error: 'Invalid Username or Password' }, status: 400
		end
	end

end
