module Parsers
  class DownloadAudioFileResponse
    attr_accessor :success
    attr_accessor :error

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
      @error = response[1].strip unless success
    end

  end
end
