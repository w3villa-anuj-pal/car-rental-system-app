class UsersController < ApplicationController
  before_action :find_user, only: [:show, :destroy]
  before_action :require_admin_user, only: [:index, :destroy,:show]

  def index
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result)
    # @pagy, @users = pagy(User.all, items: 5)
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to users_path
    flash[:alert] = "User was successfully destroyed"
  end

  def pdf
    # pdf.text "Last name:", size: 13, style: :bold 
    pdf = Prawn::Document.new(page_size: [500,600])
    pdf.text "CAR RENTAL SYSTEM PRIVATE LIMITED", size: 20,style: :bold,leading: 5
    pdf.text "Regd.Office: ZN 56Q, BAHADRABAD,HARIDWAR,INDIA-249403
    Email: temp.car.rental@gmail.com | Website: anuj-car-rental-system.com | Phone: +9157273262",size: 7,style: :bold
    pdf.text "",leading: 10
    pdf.text "User Details", size: 10,style: :bold
    pdf.stroke do
    pdf.horizontal_rule
    end
    pdf.text "", leading: 15
    pdf.text "First Name         :  #{current_user.first_name}", size: 10,leading: 10
    pdf.text "Last Name         :  #{current_user.last_name}", size: 10,leading: 10 
    pdf.text "Email id              :  #{current_user.email}", size: 10,leading: 10 
    pdf.text "Phone Number  :  #{current_user.phone_number}", size: 10,leading: 10 
    pdf.text "",leading: 25
    pdf.text "Description",size: 10, style: :bold,leading: 10
    pdf.stroke do
      pdf.horizontal_rule
    end
    pdf.text "", leading: 15
    pdf.text "Car Rental is India’s largest platform and one of the world’s largest ride-hailing  companies, serving 250+ cities across India. The Car Rental offers mobility solutions by connecting customers to drivers and a wide range of vehicles across metered taxis enabling convenience and transparency for hundreds of millions of consumers and over 1.5 million driver-partners.",size: 9
    pdf.text "", leading: 15
    pdf.text "Contact Us :  temp.car.rental@gmail.com", size: 8,style: :bold
    pdf.text "", leading: 15
    pdf.text "Regd.Office: ZN 56Q, BAHADRABAD,HARIDWAR,INDIA-249403",size: 8,:align => :center,leading: 15

    send_data(pdf.render,
              filename: "#{current_user.first_name}.pdf",
              type: 'application/pdf',
              disposition: 'inline')
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def require_admin_user
    if current_user != @user && !(current_user.has_role? :admin) 
      redirect_to root_path
    end
  end
end
