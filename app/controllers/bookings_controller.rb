class BookingsController < ApplicationController
	before_action :set_current_user, except: [:index, :show]
	before_action :book_appointment, except: [:index, :show]

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

	def home_cleaning
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
				book_service('HomeCleaning')
			end
		else
			return render json: { error: 'Invalid Data' }, status: 400
		end
	end

	def office_cleaning
		@service = OfficeCleaning.new({
			sqft: params[:sqft],
			kitchen: params[:kitchen]
		})

		if @service.save
			book_service('OfficeCleaning')
		else
			return render json: { error: 'Invalid Data' }, status: 400
		end
	end

	def car_wash
		@service = CarWash.new({
			cars: params[:cars], 
			water_provided: params[:water_provided]
		})

		if @service.save
			book_service('CarWash')
		else
			return render json: { error: 'Invalid Data' }, status: 400
		end
	end

	def drivers
		@service = Driver.new({
			day_or_night: params[:day_or_night]
		})

		if @service.save
			error = book_cars(@service.id)
			if error.has_key?(:msg)
				return render json: { error: error[:msg] }, status: error[:status]
			else
				book_service('Driver')
			end
		else
			return render json: { error: 'Invalid Data' }, status: 400
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

		def book_cars(id)
			valid_cars = []
			if params.has_key?(:cars)
				params[:cars].each do |car|
					car = Car.new({ 
						model: car[:model], 
						wheel_type: car[:wheel_type], 
						driver_id: id, 
						owned: car[:owned]
					})

					valid_cars << car if car.valid?
				end
				if valid_cars.size == params[:cars].size
					valid_cars.each do |car|
						car.save
					end
					return {}
				else
					return { msg: 'Invalid Car Data', status: 400 }
				end
			else
				return { msg: 'Invalid Data', status: 400 }
			end
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

		def book_service(service_name)
			quote = calculate_hc_quote
			providers = calculate_hc_providers
			time = calculate_hc_time

			booking_data = {
				quote: quote,
				appointment_id: @appointment.id,
				serviceable_type: service_name,
				serviceable_id: @service.id,
				notes: params[:notes],
				num_of_providers: providers,
				time_required: time
			}

			booking = Booking.new(booking_data)
			if booking.save
				return render json: booking, status: 201
			else
				return render json: { error: 'Invalid Data' }, status: 400
			end
		end

		def book_appointment()
			appointment_data = {
				user_id: @current_user.id,
				service_date: params[:serviceDate]
			}

			@appointment = Appointment.new(appointment_data)
			if @appointment.save
				return @appointment
			else
				return render json: { error: 'Invalid Data' }, status: 400
			end
		end

		def calculate_hc_quote
			total = 0

			if params[:bedrooms] == 2 && params[:bathrooms] == 2 && params[:kitchens] == 1 && params[:livingrooms] == 1
				total = 800
				total += params[:loads] * 350
				total += params[:ironed] * 300
			elsif params[:bedrooms] == 3 && params[:bathrooms] == 3 && params[:kitchens] == 1 && params[:livingrooms] == 1
				total = 1000
				total += params[:loads] * 350
				total += params[:ironed] * 300
			else
				total += params[:bedrooms] * 300
				total += params[:bathrooms] * 200
				total += params[:kitchens] * 250
				total += params[:livingrooms] * 250
				total += params[:loads] * 350
				total += params[:ironed] * 300
			end
			p 'quote'
			p total
			return total
		end

		def calculate_hc_time
			p 'time'
			total = 0 
			total += params[:bedrooms] * 0.50
			total += params[:bathrooms] * 0.50
			total += params[:kitchens] * 1.00
			total += params[:livingrooms] * 0.50
			total += params[:loads] * 4.00
			total += params[:ironed] * 4.00
			p total
			return total
		end

		def calculate_hc_providers
			p 'bedrooms divided by three'
			p params[:bedrooms] / 3.0
			p 'providers'
			p (params[:bedrooms] / 3.0).ceil
			return (params[:bedrooms] / 3.0).ceil
		end
end
