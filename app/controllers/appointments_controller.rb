class AppointmentsController < ApplicationController

	def index
		render json: Appointment.all, status: 200
	end

	def show
		if appointments = Appointment.where(user_id: params[:id])
			return render json: appointments, status: 200
		else
			return render json: { error: 'Appointments Not Found' }, status: 400
		end
	end

	def create
		apptData = {
			user_id: params[:id],
			# service_date: params[:serviceDate]
		}

		appointment = Appointment.new(apptData)

		if appointment.save
			return render json: appointment, status: 201
		else
			return render json: { error: 'Invalid Input' }, status: 400
		end
	end

	def complete
		if appointment = Appointment.find_by(id: params[:id])
			appointment.completed = true;
			if appointment.save
				return render json: appointment, status: 200
			else
				return render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
			end
		else
			return render json: { error: 'Appointment Not Found' }, status: 400
		end
	end

	def pay
		if appointment = Appointment.find_by(id: params[:id])
			appointment.paid = true;
			if appointment.save
				render json: appointment, status: 200
			else
				render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
			end
		else
			render json: { error: 'Appointment Not Found' },
			status: 400
		end
	end

	def edit
		if appointment = Appointment.find_by(id: params[:id])
			appointment.service_date = params[:serviceDate]
			if appointment.save
				render json: appointment, status: 200
			else
				render json: { error: 'Invalid Input' }, status: 400
			end
		else
			render json: { error: 'Appointment Not Found' }, status: 400
		end
	end

	def cancel
		if appointment = Appointment.find_by(id: params[:id])
			appointment.canceled = true
			if appointment.save
				render json: appointment, status: 200
			else
				render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
			end
		else
			render json: { error: 'Appointment Not Found' }, status: 400
		end
	end

end