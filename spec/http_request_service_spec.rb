require "./src/clean_code/utilities/http_request_service.rb"
require "./spec/mocks/response_mock.rb"

RSpec.describe HttpRequestService do
    context "Checking response status" do
        it "properly identifies a successful response" do
            httṕ_request_service = HttpRequestService.new
            
            response = ResponseMock.new(200)
            is_successful = httṕ_request_service.is_successful_response(response)

            expect(is_successful).to eq true
        end

        it "properly identifies an unsuccessful response" do
            httṕ_request_service = HttpRequestService.new
            
            response = ResponseMock.new(500)
            is_successful = httṕ_request_service.is_successful_response(response)

            expect(is_successful).to eq false
        end
    end
end