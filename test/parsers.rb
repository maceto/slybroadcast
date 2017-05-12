require_relative "helper"

describe Parsers do

  describe 'CampaignActionsResponse' do

    it 'should return session ID' do

      response = "OK\nSession ID=123456"
      result = Parsers::CampaignActionsResponse.new(response)
      assert result.success?
      assert_equal result.session_id, "123456"

    end

    it 'should return error description' do

      response = "ERROR\nc_uid: required"
      result = Parsers::CampaignActionsResponse.new(response)
      assert result.failed?
      assert_equal result.error, "c_uid: required"

    end

  end

  describe 'CampaignCallResponse' do

    it 'should return session ID' do

      response = "OK\nSession ID=123456\nNumber of Phone=123"
      result = Parsers::CampaignCallResponse.new(response)
      assert result.success?
      assert_equal result.session_id, "123456"
      assert_equal result.number_of_phone, "123"

    end

    it 'should return error description' do

      response = "ERROR\nc_uid: required"
      result = Parsers::CampaignCallResponse.new(response)
      assert result.failed?
      assert_equal result.error, "c_uid: required"

    end

  end

  describe 'RemainingMessagesResponse' do

    it 'should return session ID' do

      response = "remaining messages=123456\npending messages=123"
      result = Parsers::RemainingMessagesResponse.new(response)
      assert result.success?
      assert_equal result.remaining_messages, "123456"
      assert_equal result.pending_messages, "123"

    end

    it 'should return error description' do

      response = "ERROR\nc_uid: required"
      result = Parsers::RemainingMessagesResponse.new(response)
      assert result.failed?
      assert_equal result.error, "c_uid: required"

    end

  end

  describe 'DownloadAudioFileResponse' do

    it 'should return true' do

      response = "OK"
      result = Parsers::DownloadAudioFileResponse.new(response)
      assert result.success?

    end

    it 'should return error description' do

      response = "ERROR\nc_uid: required"
      result = Parsers::DownloadAudioFileResponse.new(response)
      assert result.failed?
      assert_equal result.error, "c_uid: required"

    end

  end

  describe 'AudioFileListResponse' do

    it 'should return true' do

      response = "\"r15294b17042522420232165.wav\"|\"123456\"|\"2017-04-25 22:42:25\"\n\"b15294b187575.wav\"|\"recording20160425-31049-1mq2hk7\"|\"2017-05-03 20:39:11\""
      result = Parsers::AudioFileListResponse.new(response)
      assert result.success?
      assert_equal 2, result.list.count

    end

    it 'should return error description' do

      response = "ERROR\nc_uid: required"
      result = Parsers::AudioFileListResponse.new(response)
      assert result.failed?
      assert_equal result.error, "c_uid: required"

    end

  end

end
