class HttpRequestServiceMock
    include HTTParty
  
    def initialize(successful = true)
        @successful = successful
    end

    def post(url, payload)
        "response"
    end

    def is_successful_response(response)
        @successful
    end
end