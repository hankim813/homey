class ProvidersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :find]

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
      birthday: params[:birthday].to_i,
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
    if sp = ServiceProvider.find_by(id: params[:id])
      spData = {
        email: params[:email],
        password: params[:password],
        first_name: params[:firstName],
        last_name: params[:lastName],
        gender: params[:gender].to_i,
        birthday: params[:birthday].to_i,
        phone: params[:phone],
        years_experience: params[:years_experience],
        service: params[:service],
        address: params[:address]
      }
      sp.update_attributes(spData)

      if sp.save
        return render json: sp, status:200
      else
        return render json: { error: 'Invalid Form Fields' }, status: 400
      end
    else
      return render json: { error: 'ServiceProvider Not Found' }, status: 400
    end
  end

  def delete
    if sp = ServiceProvider.find_by(id: params[:id])
      if sp.delete
        return render json: {}, status:200
      else
        return render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
      end
    else
      return render json: { error: 'ServiceProvider Not Found' }, status: 400
    end
  end
end
