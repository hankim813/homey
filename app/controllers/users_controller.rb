class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: [:create, :find, :fb]

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
		if user = User.find_by(id: params[:id])
			render json: user
		else
			render json: { error: 'User Not Found' }, status: 400
		end
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

	def edit
		user = User.find_by(id: params[:id])
		userData = {
			first_name: params[:first_name],
			last_name: params[:last_name],
			gender: params[:gender].to_i,
			age: params[:age].to_i,
			phone: params[:phone]
		}
		user.update_attributes(userData)

		if user.save
			render json: {}, status:200
		else
			render json: { error: 'Invalid form fields' }, status: 400
		end
	end

	def delete
		user = User.find_by(id: params[:id])
		if user.delete
			render json: {}, status:200
		else
			render json: { error: 'Invalid form fields' }, status: 400
		end
	end

	def fb
		if user = User.find_by(email: params[:email])
			render json: {
				token: user.generate_auth_token,
				user: user.id
			}
		else
			userData = {
				email: params[:email],
				password: params[:password],
				first_name: params[:first_name],
				last_name: params[:last_name],
				gender: params[:gender] === 'male' ? 0 : 1
			}
			user = User.new(userData)
			if user.save
				render json: {
					token: user.generate_auth_token,
					user: user.id
				}
			else
				render json: { error: 'Invalid form fields' }, status: 400
			end
		end
	end

end
