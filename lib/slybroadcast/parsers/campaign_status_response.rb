module Parsers
  class CampaignStatusResponse
    attr_accessor :success
    attr_accessor :error
    attr_accessor :call

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
      @success = !body.include?('ERROR')

      unless success
        response = body.split("\n")
        @error = response[1].strip
      else
        session_id, phone_number, status, failure_reason, delivery_time, carrier = body.gsub('var=','').split('|', 6)
        @call = {
          session_id: session_id,
          phone_number: phone_number,
          status: status,
          failure_reason: failure_reason,
          delivery_time: delivery_time,
          carrier: carrier
        }
      end
    end

  end
end
