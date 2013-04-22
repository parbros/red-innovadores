require 'net/http'
require 'uri'

class RemoteUser < Typhoid::Resource

  # self.site = 'http://lms.redinnovacion.org'  # The base-url for where we plan to retrieve data
  self.site = 'http://localhost:3020'  # The base-url for where we plan to retrieve data
  self.path = '/api/v1/accounts/1/users' # Specific path to get the data for this Class
  
  # development access token
  ACCESS_TOKEN = 'NKcZzqdkrjLzvu8j7anK5yMs2og2wMCh3BDSgO72W9ZU08eqXDrFzQXOLHnhOCoR'
  
  #production access token
  # ACCESS_TOKEN = '1XHwVBPAnk46sLXw1B8NBEzZBYD8HQAgtLMvBDCHQ6HAuqHNNWglkBb9BWqARDDW'

  def self.create_user(pseudonym_unique_id, pseudonym_password)
    # request = build_request("#{site}#{path}?user[name]=#{username}&pseudonym[unique_id]=#{pseudonym_unique_id}&pseudonym[password]=#{pseudonym_password}&access_token=skSXWvkSeLotRT1ecatzN0oedHuRDt9d2gch3qxpBkpdvU8OvtbDTPceBNaIUOUu", {method: :post})
    # puts request.request_uri
    # user = self.run(request)
    postData = Net::HTTP.post_form(URI.parse("#{site}#{path}"), 
                                   {'pseudonym[unique_id]' => pseudonym_unique_id,
                                     'pseudonym[password]' => pseudonym_password,
                                     'access_token' => ACCESS_TOKEN})
  end
  
end
