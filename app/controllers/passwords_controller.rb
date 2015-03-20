class PasswordsController < ApplicationController
  skip_before_action :authenticate_request

  #contact and generate token are used to send token email
  #verify_token and reset_user_password are used after user receives token email and submits their token with new password

  def generate_token
    random_token = rand(36**8).to_s(36)
    token = PasswordToken.new(access_token: random_token)
    if token.save
      return render json: token, status: 201
    else
      return render json: { error: 'Invalid Data' }, status: 400
    end
    token
  end

  def contact
    token = generate_token
    PasswordNotifier.perform_async(params[:email], token)
  end

  def token_verified(token)
    if token = PasswordToken.find_by(passkey: token)
      return true
    else
      return false
    end
  end

  def delete_token(token)
    if token = PasswordToken.find_by(passkey: token)
      if token.delete
        render status: 200
      else
        return render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
      end
    else
      return render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
    end
  end

  def reset_user_password
    token = params[:token]
    if user = User.find_by(email: params[:email])
      if token_verified(token)
        user.password = params[:password]
        if user.save
          delete_token(token)
          return render json: user, status: 200
        else
          return render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
        end
      else
        return render json: { error: 'Something Went Wrong, Please Try Again' }, status: 400
      end
    else
      return render json: { error: "User Not Found, Invalid Data" }, status: 400
    end
  end
end