class DiscountsController < ApplicationController

	def create
		coupon = Discount.new({
			code: params[:code],
			percentage: params[:percentage],
			times_redeemed: 0,
			limit: params[:limit],
			reusable: params[:reusable] == '1',
			admin_id: params[:id]
		})

		if coupon.save
			return render json: coupon, status: 201
		else
			return error_msg
		end
	end
end
