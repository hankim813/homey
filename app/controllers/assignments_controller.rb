class AssignmentsController < ApplicationController

	def create
		if appt = Appointment.find_by(id: params[:appt_id])
			if sp = ServiceProvider.find_by(id: params[:sp_id])
				assignment = Assignment.new({
					appointment_id: appt.id,
					service_provider_id: sp.id	
				})
				if assignment.save
					appt.update_attributes(assigned: true)
					return render json: assignment, status: 201
				else
					return error_msg
				end
			else
				return render json: { error: 'Service Provider does not exist' }, status: 400
			end
		else
			return render json: { error: 'Appointment does not exist' }, status: 400
		end
	end

	def destroy
		if appt = Appointment.find_by(id: params[:appt_id])
			if sp = ServiceProvider.find_by(id: params[:sp_id])
				assignment = Assignment.find_by(
					appointment_id: appt.id,
					service_provider_id: sp.id	
				)
				if assignment.destroy
					appt.update_attributes(assigned: false)
					return render json: appt, status: 200
				else
					return error_msg
				end
			else
				return render json: { error: 'Service Provider does not exist' }, status: 400
			end
		else
			return render json: { error: 'Appointment does not exist' }, status: 400
		end
	end

end
