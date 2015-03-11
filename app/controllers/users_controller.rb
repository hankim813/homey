class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: [:create, :find, :fb]
	before_action :authenticate_user_access, except: [:find, :create, :fb]

	def index
		render json: User.all, status: 200
	end

	def find
		user = User.find_by(email: params[:email])

		if user && user.authenticate(params[:password])
			return render json: {
				token: user.generate_auth_token,
				userId:  user.id
			}, status: 201
		else
			return render json: { error: 'Invalid Username or Password' }, status: 400
		end
	end

	def show
		if user = User.find_by(id: params[:id])
			return render json: user, status: 200
		else
			return render json: { error: 'User Not Found' }, status: 400
		end
	end

	def create
		# Check if the user exists already
		if User.find_by(email: params[:email])
			return render json: { error: "Email exists already, please login" }, status: 400
		end

		user_data = {
			email: params[:email],
			password: params[:password],
			first_name: params[:firstName],
			last_name: params[:lastName],
			gender: params[:gender].to_i,
			birthday: params[:birthday],
			phone: params[:phone]
		}
		user = User.new(user_data)

		if user.save
			return render json: {
				token: user.generate_auth_token,
				userId: user.id
			}, status: 201
		else
			return render json: { error: 'Invalid Data' }, status: 400
		end
	end

	def edit
		user_data = {
			first_name: params[:first_name],
			last_name: params[:last_name],
			gender: params[:gender].to_i,
			birthday: params[:birthday],
			phone: params[:phone]
		}
		@current_user.update_attributes(user_data)

		if @current_user.save
			return render json: @current_user, status:200
		else
			return render json: { error: 'Invalid Form Fields' }, status: 400
		end
	end

	def delete
		appointments = @current_user.appointments
		if @current_user.delete
			if appointments
				appointments.each do |appt|
					appt.canceled = true
					appt.save
				end
			end
			return render json: {}, status:200
		else
			return render json: { error: 'Something Went Wrong, Please Try Again' }, status: 500
		end
	end

	def fb
		if user = User.find_by(email: params[:email])
			return render json: {
				token: user.generate_auth_token,
				userId: user.id
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
				return render json: {
					token: user.generate_auth_token,
					userId: user.id
				}, status: 201
			else
				return render json: { error: 'Invalid form fields' }, status: 400
			end
		end
	end

	private

		def authenticate_user_access
      # once the routes are more restful, check that the current_user and the params[:id] match
			return no_access if @current_sp
		end

end
