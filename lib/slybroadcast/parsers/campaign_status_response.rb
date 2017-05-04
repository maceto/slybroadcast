module Parsers
  class CampaignStatusResponse
    attr_accessor :success
    attr_accessor :error
    attr_accessor :session_id
    attr_accessor :number_of_phone

    def initialize(body)
      response_parse(body)
    end

    def failed?
      not success?
    end

    def success?
      success
    end

    private

    def response_parse(body)
      response = body.split("\n")
      @success = response[0].strip == 'OK'

      unless success
        @error = response[1]
      else
        @session_id = response[1].split("=")[1]
        @number_of_phone = response[2].split("=")[1]
      end
    end

  end
end
