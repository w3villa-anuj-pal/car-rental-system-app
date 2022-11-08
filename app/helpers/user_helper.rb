module UserHelper
  attr_reader :client
  
  def validate_phone(telephone)
    @client = Twilio::REST::Client.new account_sid, auth_token
    
    if phone_number == ""
      return false
    end

    begin
      result = @client.lookups.v1.phone_numbers(phone_number).fetch
    rescue Exception => e 
      return false
    end

    return true  
  end


  def send_text(user,message)
      client_obj = Twilio::REST::Client.new account_sid, auth_token
      client_obj.api.account.messages.create(
      from: phone_number,
      to: user.phone_number,
      body: message
    )
  end
  
  def account_sid
    Rails.application.credentials.twilio[:account_sid]
  end 
  
  def auth_token
    Rails.application.credentials.twilio[:auth_token]
  end  
  
  def phone_number
    Rails.application.credentials.twilio[:phone_number]
  end
end
