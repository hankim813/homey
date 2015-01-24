class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: [:create, :find, :fb]

	def index
		render json: User.all, status: 200
	end

	def find
		user = User.find_by(email: params[:email])

		if user && user.authenticate(params[:password])
			render json: {
				token: user.generate_auth_token,
				user:  user.id
			}, status: 201
		else
			render json: { error: 'Invalid Username or Password' }, status: 400
		end
	end

	def show
		if user = User.find_by(id: params[:id])
			render json: user, status: 200
		else
			render json: { error: 'User Not Found' }, status: 400
		end
	end

	def create
		user_data = {
			email: params[:email],
			password: params[:password],
			first_name: params[:firstName],
			last_name: params[:lastName],
			gender: params[:gender].to_i,
			age: params[:age].to_i,
			phone: params[:phone]
		}
		user = User.new(user_data)

		if user.save
			render json: {
				token: user.generate_auth_token,
				user: user.id
			}, status: 201
		else
			render json: { error: 'Invalid Username or Password' }, status: 400
		end
	end

	def edit
		if user = User.find_by(id: params[:id])
			user_data = {
				first_name: params[:first_name],
				last_name: params[:last_name],
				gender: params[:gender].to_i,
				age: params[:age].to_i,
				phone: params[:phone]
			}
			user.update_attributes(user_data)

			if user.save
				render json: {}, status:200
			else
				render json: { error: 'Invalid Form Fields' }, status: 400
			end
		else
			render json: { error: 'User Not Found' }, status: 400
		end
	end

	def delete
		if user = User.find_by(id: params[:id])
			if user.delete
				render json: {}, status:200
			else
				render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
			end
		else
			render json: { error: 'User Not Found' }, status: 400
		end
	end

	def fb
		if user = User.find_by(email: params[:email])
			render json: {
				token: user.generate_auth_token,
				user: user.id
			}, status: 201
		else
			user_data = {
				email: params[:email],
				password: params[:password],
				first_name: params[:first_name],
				last_name: params[:last_name],
				gender: params[:gender] === 'male' ? 0 : 1
			}
			user = User.new(user_data)
			if user.save
				render json: {
					token: user.generate_auth_token,
					user: user.id
				}, status: 201
			else
				render json: { error: 'Invalid form fields' }, status: 400
			end
		end
	end

end
