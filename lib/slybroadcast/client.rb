require 'singleton'
require 'uri'
require 'net/http'
require_relative 'exceptions'
require_relative 'parsers/campaign_call_response'
require_relative 'parsers/campaign_status_response'
require_relative 'parsers/campaign_actions_response'
require_relative 'parsers/remaining_messages_response'
require_relative 'parsers/download_audio_file_response'
require_relative 'parsers/audio_file_list_response'

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
      verify: 'vmb.php',
      campaign_call: 'vmb.php',
      campaign_status: 'vmb.php',
      campaign: 'vmb.php',
      account_message_balance: 'vmb.php',
      download_audio_file: 'vmb.dla.php',
      list_audio_files: 'vmb.aflist.php'
    }.freeze

    class << self
      attr_accessor :credentials

      def method_missing(method, *args, &block)
        instance.send(method, *args, &block)
      end
    end

    def verify(**options)
      params = set_credentials(options.merge(c_option: :user_verify))
      res = make_post(endpoint_url, params)
      raise Exceptions::InvalidCredentials, 'Invalid `c_uid` or `c_password`' unless res.body.eql?("OK")
      true
    end

    def campaign_call(**options)
      params = set_credentials(options)
      res = make_post(endpoint_url, params)
      parse_response(:CampaignCallResponse, res)
    end

    def campaign_status(**options)
      params = set_credentials(options.merge(c_option: :callstatus))
      res = make_post(endpoint_url, params)
      parse_response(:CampaignStatusResponse, res)
    end

    def campaign(**options)
      params = set_credentials(options)
      res = make_post(endpoint_url, params)
      parse_response(:CampaignActionsResponse, res)
    end

    def campaign_pause(**options)
      campaign(options.merge(c_option: :pause))
    end

    def campaign_resume(**options)
      campaign(options.merge(c_option: :run))
    end

    def campaign_cancel(**options)
      campaign(options.merge(c_option: :stop))
    end

    def account_message_balance
      params = set_credentials(remain_message: '1')
      res = make_post(endpoint_url, params)
      parse_response(:RemainingMessagesResponse, res)
    end

    def download_audio_file(**options)
      params = set_credentials(options)
      res = make_post(endpoint_url, params)
      parse_response(:RemainingMessagesResponse, res)
    end

    def list_audio_files
      params = set_credentials(c_method: 'get_audio_list')
      res = make_post(endpoint_url, params)
      parse_response(:AudioFileListResponse, res)
    end

    private

    def make_post(url, params)
      Net::HTTP.post_form(
        url,
        params
      )
    end

    def parse_response(parser, response)
      result = Parsers.const_get(parser).new(response.body)
      result.success? ? result : handle_error(result.error)
    end

    def endpoint_url
      method = caller_locations(1,1).first.label.to_sym
      URI(File.join(API_URI, ENDPOINTS.fetch(method)))
    end

    def set_credentials(params)
      (self.class.credentials || {}).merge(params)
    end

    def handle_error(err)
      case err
      when 'c_uid: required'
        raise Exceptions::InvalidCredentials, err
      when 'Bad Audio, can\'t download'
        raise Exceptions::BadAudio, err
      when 'session_id: required'
        raise Exceptions::SessionIdRequired, err
      when 'already finished'
        raise Exceptions::CampaignAlreadyFinished, err
      when 'invalid or not found'
        raise Exceptions::CampaignNotFound, err
      else
        raise StandardError, err
      end
    end

  end
end
