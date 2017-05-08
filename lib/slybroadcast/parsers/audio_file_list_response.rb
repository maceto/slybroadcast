module Parsers
  class AudioFileListResponse
    attr_accessor :success
    attr_accessor :error
    attr_accessor :list

    def initialize(body)
      @list = []
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
      @success = response[0].strip != 'ERROR'
      @error = response[1].strip unless success

      @list = response.map do |line|
        system_file_name, audio_file_name, created = line.delete('\\"').split("|",3)
        {
          system_file_name: system_file_name,
          audio_file_name: audio_file_name,
          created: created
        }
      end
    end

  end
end
