class BookingsController < ApplicationController
	before_action :set_current_user, except: [:index, :show]
	before_action :book_appointment, except: [:index, :show]
	after_filter :close_deal, except: [:index, :show]

	include PriceCalculator

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
			check_and_book_laundry(@service.id)
			unless @errors
				calculate_price('home_cleaning')
				book_service('HomeCleaning') unless @errors
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
			calculate_price('office_cleaning')
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
			calculate_price('car_wash')
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
				calculate_price('driver')
				book_service('Driver')
			end
		else
			@errors = true
		end
	end

	def securities
		@service = Security.new()

		if @service.save
			book_guards(@service.id)
			unless @errors
				calculate_price('security')
				book_service('Security')
			end
		else
			@errors = true
		end
	end

	def chefs
		@service = Chef.new({
			cuisine: params[:cuisine], 
			serving_size: params[:serving_size]
		})

		if @service.save
			calculate_price('chef')
			book_service('Chef')
		else
			@errors = true
		end
	end

	def gardenings
		@service = Gardening.new({
			acres: params[:acres], 
			type: params[:type]
		})

		if @service.save
			calculate_price('gardening')
			book_service('Gardening')
		else
			@errors = true
		end
	end

	def contractors
		@service = Contractor.new({
			type: params[:type].to_i,
			problem_description: params[:problem_description],
			problem_frequency: params[:problem_frequency]
		})
		if @service.save
			book_service('Contractor')
		else
			@errors = true
		end
	end

	private

		def calculate_price(type)
			params[:user_id] = @current_user.id
			case type
				when 'home_cleaning' then data = PriceCalculator.home_cleaning(params)
				when 'office_cleaning' then data = PriceCalculator.office_cleaning(params)
				when 'car_wash' then data = PriceCalculator.car_wash(params)
				when 'driver' then data = PriceCalculator.driver(params)
				when 'security' then data = PriceCalculator.security(params)
				when 'chef' then data = PriceCalculator.chef(params)
				when 'gardening' then data = PriceCalculator.gardening(params)
				when 'contractor' then data = PriceCalculator.contractor
			end
			@time = data[:time]
			@providers = data[:providers]
			@quote = data[:quote]
			@errors = data[:errors]
		end

		def check_and_book_laundry(id)
			if (params.has_key?(:loads) && params.has_key?(:ironed))
				laundry = Laundry.new({loads: params[:loads], ironed: params[:ironed], home_cleaning_id: id})
				if !laundry.save 
					@errors = true
				end
			end
		end

		def book_guards(id)
			valid_guards = []
			if params.has_key?(:guards)
				params[:guards].each do |guard|
					new_guard = Guard.new({
						security_id: id,
						type: guard[:type].to_i,
						hours_required:	guard[:hours]
					})
					valid_guards << new_guard if new_guard.valid?
				end
				if valid_guards.size == params[:guards].size
					valid_guards.each do |guard|
						guard.save
					end
					@errors = false
				else
					@errors = true
				end
			else
				@errors = true
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
			@errors = false
			appointment_data = {
				user_id: @current_user.id,
				service_date: params[:serviceDate],
				address_id: params[:address_id]
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
end
