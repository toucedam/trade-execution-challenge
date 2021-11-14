require "httparty"

class HttpRequestService
    include HTTParty
  
    def post(url, payload)
        json_payload = JSON.dump(payload)
        self.class.post(url, body: json_payload).response
    end

    def is_successful_response(response)
        response.code.to_i == 200
    end
end