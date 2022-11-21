class CarsController < ApplicationController
  before_action :set_car ,only: [:show, :edit,:update, :destroy]
  before_action :require_admin_user, only: [:index, :new, :edit, :destroy]
  
  def index
    @q = Car.ransack(params[:q])
    @pagy, @cars = pagy(@q.result)
    # @pagy, @cars = pagy(Car.all, items: 5)
  end

  def show
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to cars_path, :notice => "Car was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to cars_path, :notice=>"Car was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @car.destroy
    redirect_to cars_path, :notice => "Car was successfully destroyed."
  end
  
  def all_cars
    @pagy, @cars = pagy(Car.all, items: 5)
  end

  def payment
    @car = Car.find(params[:id])
  end

  def success
  end

  def location
  end

  private

  def car_params
    params.require(:car).permit(:car_name, :vehicle_no, :captain_name, :seater, :vehicle_type, :image)
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def require_admin_user
    if !(current_user.has_role? :admin)
      redirect_to root_path
    end
  end

end
