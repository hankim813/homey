class AppointmentsController < ApplicationController

	def index
		render json: Appointment.all, status: 200
	end

	def show
		if params[:id].to_i == @current_user.id
			if appointments = Appointment.where(user_id: params[:id])
				return render json: appointments, status: 200
			else
				return render json: { error: 'Appointments Not Found' }, status: 400
			end
		else
			return render json: { error: 'You have no access' }, status: 403
		end
	end

	def create
		appointment = Appointment.new()

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
		if appointment = Appointment.find_by(id: params[:id]) && appointment.user.id == @current_user.id
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

	# def completed
	# 	completed_appts = Appointment.where(completed: true)
	# 	return render json: completed_appts, status: 200
	# end

	# def incomplete
	# 	incomplete_appts = Appointment.where(completed: false)
	# 	return render json: incomplete_appts, status: 200
	# end

	# def paid
	# 	paid_appts = Appointment.where(paid: true)
	# 	return render json: paid_appts, status: 200
	# end

	# def unpaid
	# 	unpaid_appts = Appointment.where(paid: false)
	# 	return render json: unpaid_appts, status: 200
	# end

	# def assigned
	# 	assigned_appts = Appointment.where(assigned: true)
	# 	return render json: assigned_appts, status: 200
	# end

	def unassigned
		unassigned_appts = Appointment.where(assigned: false)
		return render json: unassigned_appts, status: 200
	end

	def upcoming
    today = Date.today
    thirty_days_from_now = 30.days.from_now
    if appointments = Appointment.where(service_date: today..thirty_days_from_now)
      return render json: appointments, status: 200
    else
      return render json: { error: 'No upcoming appointments' }, status: 400
    end
  end

	def past
		p "in past"
		today = Date.today
		thirty_days_ago = 30.days.ago
		if appointments = Appointment.where(service_date: thirty_days_ago..today)
			return render json: appointments, status: 200
		else
			return render json: { error: 'No past appointments' }, status: 400
		end
	end

end
