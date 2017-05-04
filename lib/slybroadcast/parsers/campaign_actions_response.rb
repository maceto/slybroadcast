module Parsers
  class CampaignActionsResponse
    attr_accessor :success
    attr_accessor :error
    attr_accessor :session_id

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
        @error = response[1].gsub(/\d\s?/, '').strip
      else
        @session_id = response[1].gsub(/[^0-9]/i, '').strip
      end
    end

  end
end
