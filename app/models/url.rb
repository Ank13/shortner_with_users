require 'uri'

class Url < ActiveRecord::Base
  validate :url_format
  
  def url_format
    if (long_url.match URI.regexp(['http', 'https'])).nil?
      errors.add(:long_url, "That's not a valid URL!")
    end
  end 
end


# Any non-empty string
# Any non-empty string that starts with "http://" or "https://"
# Any string that the Ruby URI module says is valid
# Any URL-looking thing which responds to a HTTP request, i.e., we 
# actually check to see if the URL is accessible via HTTP


    # if Net::HTTP.get_response(uri).code_type != "Net::HTTPOK"
    #   errors.add(:check_for_response, "No response from your URL")
    # end
