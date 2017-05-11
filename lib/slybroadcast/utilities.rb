module Slybroadcast
  module Utilities
    extend self

    #
    # Usage
    #
    #   Slybroadcast::Utilities.callback_parser(body) do |session_id, phone_number, status, failure_reason, delivery_time, carrier|
    #       {
    #         session_id: session_id,
    #         phone_number: phone_number,
    #         status: status,
    #         failure_reason: failure_reason,
    #         delivery_time: delivery_time,
    #         carrier: carrier
    #       }
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
