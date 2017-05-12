module Slybroadcast
  module Utilities
    extend self

    #
    # Usage
    #   example_body = "9996130985|9996449444|OK||2017-05-11 17:38:18|verizon wireless:6006 - svr/2"
    #
    #   Slybroadcast::Utilities.callback_parser(example_body) do |session_id, phone_number, status, failure_reason, delivery_time, carrier|
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
      session_id, phone_number, status, failure_reason, delivery_time, carrier = body.split('|', 6)
      yield session_id, phone_number, status, failure_reason, delivery_time, carrier
    end

  end
end
