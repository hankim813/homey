class BookingsController < ApplicationController
	before_action :set_current_user, only: [:home_cleaning]

	def index
		render json: Booking.all, status: 200
	end

	def show
		if booking = Booking.find_by(appointment_id: params[:id])
			render json: booking, status: 200
		else
			render json: { error: 'Booking Not Found' }, status: 400
		end
	end

	def home_cleaning

		appointment_data = {
			user_id: @current_user.id,
			service_date: params[:serviceDate]
		}

		service_data = {
			bedrooms: params[:bedrooms],
			bathrooms: params[:bathrooms],
			kitchens: params[:kitchens],
			livingrooms: params[:livingrooms]
		}

		# Create appointment first
		appointment = book_appointment(appointment_data)

		# Create the service
		service = HomeCleaning.new(service_data)

		if service.save
			check_and_create_laundry(service.id)

			booking_data = {
				quote: 200.00, # calculate the actual quote in the backend with params
				appointment_id: appointment.id,
				serviceable_type: "HomeCleaning",
				serviceable_id: service.id,
				notes: params[:notes],
				num_of_providers: params[:providers]
			}

			# Book everything
			booking = book_service(booking_data)
			render json: booking, status: 201
		else
			render json: { error: 'Invalid Data' }, status: 400
		end

	end

	def check_and_create_laundry(id)
		if (params.has_key?(:loads) && params.has_key?(:ironed))
			laundry = Laundry.new({loads: params[:loads], ironed: params[:ironed], home_cleaning_id: id})
			if !laundry.save 
				render json: { error: 'Invalid Data' }, status: 400
			end
		end
		return laundry
	end

	def book_service(data)
		booking = Booking.new(data)
		if booking.save
			return booking
		else
			render json: { error: 'Invalid Data' }, status: 400
		end
	end

	def book_appointment(data)
		appointment = Appointment.new(data)
		if appointment.save
			return appointment
		else
			render json: { error: 'Invalid Data' }, status: 400
		end
	end
end
