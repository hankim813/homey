class BookingsController < ApplicationController
	before_action :set_current_user, except: [:index, :show]
	before_action :book_appointment, except: [:index, :show]
	after_filter :close_deal, except: [:index, :show]

	def index
		return render json: Booking.all, status: 200
	end

	def show
		if booking = Booking.find_by(appointment_id: params[:id])
			return render json: booking, status: 200
		else
			return render json: { error: 'Booking Not Found' }, status: 400
		end
	end

	def home_cleanings
		service_data = {
			bedrooms: params[:bedrooms],
			bathrooms: params[:bathrooms],
			kitchens: params[:kitchens],
			livingrooms: params[:livingrooms]
		}

		@service = HomeCleaning.new(service_data)

		if @service.save
			error = check_and_book_laundry(@service.id)
			if error.has_key?(:msg)
				return render json: { error: error[:msg] }, status: error[:status]
			else
				calculate_hc_quote
				book_service('HomeCleaning')
			end
		else
			@errors = true
		end
	end

	def office_cleanings
		@service = OfficeCleaning.new({
			sqft: params[:sqft],
			kitchen: params[:kitchen]
		})

		if @service.save
			calculate_oc_quote
			book_service('OfficeCleaning')
		else
			@errors = true
		end
	end

	def car_washes
		@service = CarWash.new({
			cars: params[:cars], 
			water_provided: params[:water_provided]
		})

		if @service.save
			calculate_cw_quote
			book_service('CarWash')
		else
			@errors = true
		end
	end

	def drivers
		@service = Driver.new() 

		if @service.save
			book_cars(@service.id)
			unless @errors
				calculate_d_quote
				book_service('Driver')
			end
		else
			@errors = true
		end
	end

	def securities
		@service = Security.new()

		if @service.save
			error = book_guards(@service.id)
			if error.has_key?(:msg)
				return render json: { error: error[:msg] }, status: error[:status]
			else
				book_service('Security')
			end
		else
			return render json: { error: 'Invalid Data' }, status: 400
		end
	end

	def chefs
		@service = Chef.new({
			cuisine: params[:cuisine], 
			serving_size: params[:serving_size]
		})

		if @service.save
			book_service('Chef')
		else
			return render json: { error: 'Invalid Data' }, status: 400
		end
	end

	def gardenings
		@service = Gardening.new({
			acres: params[:acres], 
			type: params[:type]
		})

		if @service.save
			book_service('Gardening')
		else
			return render json: { error: 'Invalid Data' }, status: 400
		end
	end

	def contractors
		@service = Contractor.new({
			type: params[:type],
			problem_description: params[:problem_description],
			problem_frequency: params[:problem_frequency]
		})

		if @service.save
			book_service('Contractor')
		else
			return render json: { error: 'Invalid Data' }, status: 400
		end
	end

	private

		def check_and_book_laundry(id)
			if (params.has_key?(:loads) && params.has_key?(:ironed))
				laundry = Laundry.new({loads: params[:loads], ironed: params[:ironed], home_cleaning_id: id})
				if !laundry.save 
					return { msg: 'Invalid Data', status: 400 }
				end
			end
			return {}
		end

		def book_guards(id)
			valid_guards = []
			if params.has_key?(:guards)
				params[:guards].each do |guard|
					guard = Guard.new({
						security_id: id,
						type: guard[:type],
						hours_required:	guard[:hours_required]
					})
					valid_guards << guard if guard.valid?
				end
				if valid_guards.size == params[:guards].size
					valid_guards.each do |guard|
						guard.save
					end
					return {}
				else
					return { msg: 'Invalid Data', status: 400 }
				end
			else
				return { error: 'Invalid Data', status: 400 }
			end
		end

		def book_cars(id)
			valid_cars = []
			if params.has_key?(:cars)
				params[:cars].each do |car|
					new_car = Car.new({
						driver_id: id,
						wheel_type: car[:wheel_type],
						hours:	car[:hours],
						owned: car[:owned],
						model: car[:model],
						day_or_night: car[:day_or_night]
					})
					valid_cars << new_car if new_car.valid?
				end
				if valid_cars.size == params[:cars].size
					valid_cars.each do |car|
						car.save
					end
					@errors = false
				else
					@errors = true
				end
			else
				@errprs = true
			end
		end

		def book_service(service_name)
			booking_data = {
				quote: @quote,
				serviceable_type: service_name,
				serviceable_id: @service.id,
				notes: params[:notes],
				num_of_providers: @providers,
				time_required: @time
			}

			@booking = Booking.new(booking_data)
			@errors = !@booking.valid?
		end

		def book_appointment
			appointment_data = {
				user_id: @current_user.id,
				service_date: params[:serviceDate]
			}

			@appointment = Appointment.new(appointment_data)
		end

		def close_deal
			return error_msg if @errors

			if @appointment.save 
				@booking.appointment = @appointment
				if @booking.save
					return render json: @appointment, status: 201 
				else
					return error_msg
				end
			else	
				return error_msg
			end
		end

	# For Home Cleanings
		def calculate_hc_quote
			calculate_hc_time
			calculate_hc_providers
			if params[:bedrooms] == 2 && params[:bathrooms] == 2 && params[:kitchens] == 1 && params[:livingrooms] == 1
				@quote = 1000
				@quote += params[:loads] * 350
				@quote += params[:ironed] * 300
				@quote += ((@providers - 1) * 300)
			elsif params[:bedrooms] == 3 && params[:bathrooms] == 3 && params[:kitchens] == 1 && params[:livingrooms] == 1
				@quote = 1500
				@quote += params[:loads] * 350
				@quote += params[:ironed] * 300
				@quote += ((@providers - 1) * 300)
			else
				@quote = params[:bedrooms] * 400
				@quote += params[:bathrooms] * 200
				@quote += params[:kitchens] * 300
				@quote += params[:livingrooms] * 300
				@quote += params[:loads] * 350
				@quote += params[:ironed] * 300
				@quote += (@providers - 1) * 300
			end
		end

		def calculate_hc_time
			@time = params[:bedrooms] * 0.50
			@time += params[:bathrooms] * 0.50
			@time += params[:kitchens] * 1.00
			@time += params[:livingrooms] * 0.50
			@time += params[:loads] * 4.00
			@time += params[:ironed] * 4.00
		end

		def calculate_hc_providers
			@providers = (params[:bedrooms] / 3.0).ceil
		end

	# For Office Cleaning
		def calculate_oc_quote
			calculate_oc_time
			calculate_oc_providers
			@quote = params[:sqft] * 2
			@quote += 300 if params[:kitchen] 
			@quote += (@providers - 1) * 400
		end

		def calculate_oc_time
			@time = params[:sqft] / 250.00
		end

		def calculate_oc_providers 
			@providers = ((params[:sqft] - 500) / 1000).ceil + 1
		end

	# For Car Wash
		def calculate_cw_quote
			calculate_cw_time
			calculate_cw_providers
			@quote = params[:cars] * 500
		end

		def calculate_cw_time
			@time = params[:cars]
		end

		def calculate_cw_providers
			@providers = params[:cars]
		end

	# For Drivers
		def calculate_d_quote
			calculate_d_time
			calculate_d_providers
			@quote = 0
			params[:cars].each do |car|
				if to_boolean(car[:owned])
					@quote += 200 if car[:day_or_night].to_i == 0
					car[:hours] >= 12 ? (@quote += (car[:hours] - 12) * 300 + 1500) : (@quote += car[:hours] * 300)  
				else
					@quote += 200 if car[:day_or_night].to_i == 0
					car[:wheel_type].to_i == 0 ? @quote += 3500 : @quote += 7000
					car[:hours] >= 12 ? (@quote += (car[:hours] - 12) * 300 + 1500) : (@quote += car[:hours] * 300)
				end
			end

		end

		def calculate_d_time
			@time = 0
			params[:cars].each do |car|
				@time += car[:hours]
			end
		end

		def calculate_d_providers
			@providers = params[:cars].size
		end
end
