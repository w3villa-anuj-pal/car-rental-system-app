class CarsController < ApplicationController
  
  def index
    @pagy, @cars = pagy(Car.all, items: 5)
  end

  def all_cars
    @pagy, @cars = pagy(Car.all, items: 5)
  end

end
