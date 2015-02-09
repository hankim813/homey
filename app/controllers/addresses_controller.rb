class AddressesController < ApplicationController

	def index
		return no_access unless params[:id].to_i == @current_user.id
		if addresses = @current_user.addresses
			return render json: addresses, status: 200
		else
			return render json: { error: 'This user does not have any addresses saved.' }, status: 400
		end
	end

	def show
		if address = Address.find_by(id: params[:id])
			return render json: address, status: 200
		else
			return render json: { error: 'Address not found.' }, status: 400
		end
	end

	def create
		address = Address.new({
			building_name: params[:building_name],
			street: params[:street],
			po_box: params[:po_box],
			neighborhood: params[:neighborhood].to_i,
			user_id: @current_user.id
		})

		if address.save
			return render json: address, status: 201
		else
			return error_msg
		end
	end

	def edit
		address = Address.find_by(id: params[:id])
		if address && address.user.id == @current_user.id
			address.update_attribute(
				building_name: params[:building_name],
				street: params[:street],
				po_box: params[:po_box],
				neighborhood: params[:neighborhood],
				phone: params[:phone]
			)

			if address.save
				return render json: address, status: 200
			else
				return error_msg
			end
		else
			return render json: { error: 'Address not found.' }, status: 400
		end
	end

	def destroy
		address = Address.find_by(id: params[:id])
		if address && address.user.id == @current_user.id
			if address.destroy
				return render json: {}, status: 200
			else
				return render json: { error: 'Something went wrong, please try again.' }, status: 500
			end
		else
			return render json: { error: 'Address not found.' }, status: 400
		end
	end
end
