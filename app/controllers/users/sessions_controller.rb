include UserHelper
include ApplicationHelper

class Users::SessionsController < Devise::SessionsController
  include UserHelper
  skip_before_action :verify_authenticity_token


  # GET /resource/sign_in
  def new
   super   
  end

  # POST /resource/sign_in
  def create
      if(params[:user][:phone_number]!="")         
        if(User.find_by(phone_number: sign_in_params[:phone_number])==nil)
          flash[:alert] = "Phone number not Registered"
          redirect_to new_user_session_url   
        else
          @@id = User.find_by(phone_number: sign_in_params[:phone_number]).id
          flash[:notice] = "OTP sent your registered phone number"
          redirect_to phone_otp_path, allow_other_host: true
        end
      else
        self.resource = warden.authenticate!(auth_options)
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      end 
    end


  def phone_otp
    flash[:notice] = "OTP sent your registered phone number"
    otp = rand(10 ** 8)
    @client.send_text(User.find_by(:id => @@id),"Your otp for CarRentalSystem reg: "+otp.to_s)
    u = User.where(:id => @@id)  
    u[0].phone_code =  otp
    u[0].save(validate: false)
  end  

  def phone_otp_verify 
   
    if(User.find_by(id: @@id).phone_code.to_s == params[:'/phone_otp'][:otp_attempt])
      sign_in(:user,User.find_by(id: @@id))
      flash[:notice] = " Signed in successfully"
      redirect_to root_path
    else
      flash.now[:alert] = "Incorrect OTP"   
      render "devise/sessions/phone_otp"
      flash[:alert] = "OTP sent your registered phone number"
   
    end

  end 

  # DELETE /resource/sign_out
  def destroy

    u = User.where(:email => current_user.email)
    u[0].save

    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
     respond_to_on_destroy
  end



  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  
end