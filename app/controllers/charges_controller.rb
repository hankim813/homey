class ChargesController < ApplicationController
  def new
  end

  def create
    #if current user has a customer id,
    #create a stripe charge and pass in that customer id
    if @current_user.customer_id
      customer_id = @current_user.customer_id
    else
      # Get the credit card details submitted by the form
      token = params[:stripeToken]

      # Create a Customer
      customer = Stripe::Customer.create(
        :card => token,
        :description => "new homey"
      )

      # Save the customer ID in your database so you can use it later
      if user = User.find_by(id: @current_user.id)
        user.customer_id = customer.id

        if user.save
          p "user saved"
          return render json: user, status:200
        else
          return render json: { error: 'Invalid Form Fields' }, status: 400
        end
      else
        return render json: { error: 'User Not Found' }, status: 400
      end

      customer_id = @current_user.customer_id

    end

    # Charge the Customer instead of the card
    Stripe::Charge.create(
      :amount => 1000, # in cents
      :currency => "kes",
      :customer => customer_id
    )
    p "stripe charge created"

  end
end