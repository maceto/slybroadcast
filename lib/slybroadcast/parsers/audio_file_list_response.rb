module Parsers
  class AudioFileListResponse
    attr_accessor :success
    attr_accessor :error
    attr_accessor :list

    FIELDS = [:system_file_name, :audio_file_name, :created].freeze

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
        myh = Hash.new
        fields = line.delete('\\"').split("|")
        fields.map.with_index do |v, i|
          myh[FIELDS[i]||:no_defined] = v
        end
        myh
      end
    end

  end
end
