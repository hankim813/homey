class ProvidersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :find]
  before_action :authenticate_sp_access, except: [:find, :create]

  def index
    return render json: ServiceProvider.all, status: 200
  end

  def find
    sp = ServiceProvider.find_by(email: params[:email])

    if sp && sp.authenticate(params[:password])
      return render json: {
        token: sp.generate_auth_token_sp,
        spId:  sp.id
      }, status: 201
    else
      return render json: { error: 'Invalid username or Password' }, status: 400
    end
  end

  def show
    if sp = ServiceProvider.find_by(id: params[:id])
      return render json: sp, status: 200
    else
      return render json: { error: 'Service Provider Not Found' }, status: 400
    end
  end

  def create
    spData = {
      email: params[:email],
      password: params[:password],
      first_name: params[:first_name],
      last_name: params[:last_name],
      gender: params[:gender].to_i,
      birthday: params[:birthday],
      phone: params[:phone],
      years_experience: params[:years_experience],
      service: params[:service],
      address: params[:address]
    }

    sp = ServiceProvider.new(spData)

    if sp.save
      return render json: {
        token: sp.generate_auth_token_sp,
        spId: sp.id
      }, status: 201
    else
      return render json: { error: 'Invalid username or Password' }, status: 400
    end
  end

  def edit
    spData = {
      email: params[:email],
      password: params[:password],
      first_name: params[:first_name],
      last_name: params[:last_name],
      gender: params[:gender].to_i,
      birthday: params[:birthday],
      phone: params[:phone],
      years_experience: params[:years_experience],
      service: params[:service],
      address: params[:address]
    }
    @current_sp.update_attributes(spData)

    if @current_sp.save
      return render json: @current_sp, status:200
    else
      return render json: { error: 'Invalid Form Fields' }, status: 400
    end
  end

  def delete
    assignments = @current_sp.assignments
    appointments = @current_sp.appointments

    if @current_sp.delete
      if assignments.destroy_all
        appointments.each do |appt|
          appt.assigned = false
          appt.save
        end
      end
      return render json: {}, status:200
    else
      return render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
    end
  end

  private

    def authenticate_sp_access
      # once the routes are more restful, check that the current_sp and the params[:id] match
      return no_access if @current_user
    end
end
