class CheckoutController < ApplicationController

  def create
    @car = Car.find(params[:id])
    user = current_user
    user.cars << @car
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'inr',
          unit_amount: 23000,
          product_data: {
            name: @car.car_name,
          },
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: cars_success_url,
      cancel_url: root_url,
    })
    respond_to do |format|
      format.js
    end
  end

end
