class ChargesController < ApplicationController
  def new
  end

  def create
    #if current user has a customer id,
    #create a stripe charge and pass in that customer id
    if customer_stripe_id_exists
      p '9 exists'
      response = charge
      p '11 response'
      return render json: response, status: 201
    else

      # Create a Customer
      stripe_customer = Stripe::Customer.create(
        :card => params[:stripeToken],
        :description => "new homey"
      )

      # Save the customer ID in your database so you can use it later
      @stripe_id = stripe_customer.id
      @current_user.customer_id = @stripe_id

      if @current_user.save
        p "26 user saved"
        response = charge
        p '28 charged'
        p response
        return render json: response, status:201
      else
        return render json: { error: 'Invalid Form Fields' }, status: 400
      end
    end
  end

  private

    def customer_stripe_id_exists
      if @current_user.customer_id
        @stripe_id = @current_user.customer_id
        true
      else
        false
      end
    end

    def charge
      p '44 charged'
      p '45 stripe id'
      p @stripe_id
      Stripe::Charge.create(
      :amount => 100000,
      :currency => "KES",
      :customer => @stripe_id
      )
    end
end