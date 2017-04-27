require 'singleton'
require 'uri'
require 'net/http'

# usage:
#   Slybroadcast::Client.credentials = {
#     c_uid: 'user@example.com',
#     c_password: 'secret'
#   }
#   Slybroadcast::Client.verify
#
# or
#
#   Slybroadcast::Client.verify({
#     c_uid: 'user@example.com',
#     c_password: 'secret'
#   })
module Slybroadcast
  class Client
    include Singleton

    API_URI = 'https://www.mobile-sphere.com/gateway'.freeze
    ENDPOINTS = {
      verify: 'vmb.php'
    }.freeze

    class << self
      attr_accessor :credentials

      def method_missing(method, *args, &block)
        instance.send(method, *args, &block)
      end
    end

    def verify(**options)
      params = set_credentials(options.merge(c_option: :user_verify))

      res = Net::HTTP.post_form(
        endpoint_url,
        set_credentials(options.merge(c_option: :user_verify))
      )

      raise ArgumentError, 'Invalid `c_uid` or `c_password`' unless res.body.eql?("OK")

      true
    end

    def campaign_status(**options)
      raise NotImplementedError
    end

    def call_status(**options)
      raise NotImplementedError
    end

    def campaign_pause(**options)
      raise NotImplementedError
    end

    def campaign_resume(**options)
      raise NotImplementedError
    end

    def campaign_cancel(**options)
      raise NotImplementedError
    end

    def account_message_balance(**options)
      raise NotImplementedError
    end

    def download_audio_file(**options)
      raise NotImplementedError
    end

    def list_audio_files(**options)
      raise NotImplementedError
    end

    private

    def endpoint_url
      method = caller_locations(1,1).first.label.to_sym
      URI(File.join(API_URI, ENDPOINTS.fetch(method)))
    end

    def set_credentials(params)
      (self.class.credentials || {}).merge(params)
    end
  end
end
