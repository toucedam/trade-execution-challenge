require "httparty"

class HttpRequestServiceMock
    include HTTParty
  
    def post(url, payload)
        "response"
    end

    def is_successful_response(response)
        true
    end
end