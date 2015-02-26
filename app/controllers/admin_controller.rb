class AdminController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :find]
  before_action :authenticate_admin_access, except: [:find, :create]

  def find
    admin = Admin.find_by(email: params[:email])

    if admin && admin.authenticate(params[:password])
      return render json: {
        token: admin.generate_auth_token_admin,
        adminId:  admin.id
      }, status: 201
    else
      return render json: { error: 'Invalid username or Password' }, status: 400
    end
  end

  def show
    return render json: admin, status: 200 if admin = Admin.find_by(id: params[:id])
  end

  def create
    adminData = {
      email: params[:email],
      password: params[:password],
      first_name: params[:firstName],
      last_name: params[:lastName],
      gender: params[:gender].to_i,
      birthday: params[:birthday],
      phone: params[:phone]
    }

    admin = Admin.new(adminData)

    if admin.save
      return render json: {
        token: admin.generate_auth_token_admin,
        adminId: admin.id
      }, status: 201
    else
      return render json: { error: 'Invalid username or Password' }, status: 400
    end
  end

  def edit
    adminData = {
      email: params[:email],
      password: params[:password],
      first_name: params[:first_name],
      last_name: params[:last_name],
      gender: params[:gender].to_i,
      birthday: params[:birthday],
      phone: params[:phone]
    }
    @current_admin.update_attributes(adminData)

    if @current_admin.save
      return render json: @current_admin, status:200
    else
      return render json: { error: 'Invalid Form Fields' }, status: 400
    end
  end

  def delete
    if @current_admin.delete
      return render json: {}, status:200
    else
      return render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
    end
  end

  private

    def authenticate_admin_access
      # once the routes are more restful, check that the current_admin and the params[:id] match
      # implement authority level access
      return no_access if @current_admin.nil?
    end
end
