module Mailchimp
  
  def suscribe
    client.list_subscribe({
      :id => '3a74522133', 
      :email_address => self.email, 
      :merge_vars => {
        :FNAME => self.first_name, 
        :LNAME => self.last_name}, 
      email_type: 'html', 
      double_optin: false, 
      update_existing: true, 
      replace_interests: true, 
      send_welcome: false
    })
  end
  
  def client
    Gibbon.throws_exceptions = true
    @gb ||= Gibbon.new("9f6ce0c8e1fcd5a431b2c655026edc5e-us7")
  end
end