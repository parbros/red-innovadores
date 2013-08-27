module RemoteUser

  CANVAS_SITE = 'http://lms.redinnovacion.org'  # The base-url for where we plan to retrieve data
  # CANVAS_SITE = 'http://localhost:3020'  # The base-url for where we plan to retrieve data
  
  # development access token
  # ACCESS_TOKEN = 'SKnDkEZuzp85ByfCGrkrIWrr15tHzPJJkkTRtaaWWgtaDLCCW37tUpELaUnbPWSz'
  
  #production access token
  ACCESS_TOKEN = '1XHwVBPAnk46sLXw1B8NBEzZBYD8HQAgtLMvBDCHQ6HAuqHNNWglkBb9BWqARDDW'
  

  def create_canvas_user
    response = Typhoeus.post("#{CANVAS_SITE}/api/v1/accounts/1/users", body: { 
      user: {
        name: self.email,
        email: self.email,
      },
      pseudonym: {
        unique_id: self.username,
        password: self.password
      },
      access_token: ACCESS_TOKEN
    })
    JSON.parse(response.body)
  end
  
  def update_canvas_user
    response = Typhoeus.post("#{CANVAS_SITE}/api/v1/users/#{self.canvas_user_id}/pseudonym",
      body: {
        pseudonym: {unique_id: self.username},
        "_method"=>"put"
      },
      
      headers: {'Authorization' => "Bearer #{self.canvas_access_token}"}
    )
  end
  
  def update_email_canvas
    response = Typhoeus.post("#{CANVAS_SITE}/api/v1/users/#{self.canvas_user_id}",
      body: {
        user: {email: self.email},
        "_method"=>"put"
      },
      
      headers: {'Authorization' => "Bearer #{self.canvas_access_token}"}
    )
  end
end
