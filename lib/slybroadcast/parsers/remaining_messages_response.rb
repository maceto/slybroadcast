module Parsers
  class RemainingMessagesResponse
    attr_accessor :success
    attr_accessor :error
    attr_accessor :remaining_messages
    attr_accessor :pending_messages

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
      @success = response[0].include?('remaining')

      unless success
        @error = response[1].strip
      else
        @remaining_messages = response[0].gsub(/[^0-9]/i, '').strip
        @pending_messages = response[1].gsub(/[^0-9]/i, '').strip
      end
    end

  end
end
