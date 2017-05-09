module Slybroadcast
  module Utilities
    extend self

    #
    # Parser for callback post.
    #
    # Posible columns : session_id, phone_number, status, failure_reason, delivery_time, carrier
    # When status is not OK the four column is nil
    # When statis is NOT OK the four column contein the failure reason
    #
    # Usage
    #
    #   Slybroadcast::Utilities.callback_parser(body) do |session_id, phone_number, status, failure_reason, delivery_time, carrier|
    #     puts "#{session_id}, #{phone_number}, #{status}, #{failure_reason}, #{delivery_time}, #{carrier}"
    #   end
    #
    def callback_parser(body)
      response = body.split("\n")
      response.map do |line|
        line.delete!('\\"')
        cols = line.split("|",6)
        cols.compact!
        cols.insert(3,nil) if cols.size == 5
        yield *cols
      end
    end

  end
end
