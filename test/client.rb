require_relative "helper"

describe Slybroadcast::Client do
  describe 'verify' do

    it 'should be true' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "OK")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert Slybroadcast::Client.verify({})
      end

    end

    it 'should be false' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "ERROR")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert_raises Slybroadcast::Exceptions::InvalidCredentials do
          Slybroadcast::Client.verify({})
        end
      end

    end

  end

  describe 'campaign_call' do

    it 'should return session ID' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "OK\nsession ID=123456\nNumber of Phone=2")

      Net::HTTP.stub :post_form, mocked_reponse do
        result = Slybroadcast::Client.campaign_call({})
        assert_equal result.session_id, "123456"
        assert_equal result.number_of_phone, "2"
      end

    end

    it 'should raise Exceptions::InvalidCredentials' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "ERROR\nc_uid: required")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert_raises Slybroadcast::Exceptions::InvalidCredentials do
          Slybroadcast::Client.campaign_call({})
        end
      end

    end

  end

  describe 'campaign_status' do

    it 'should return session ID' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "var=9996130985|9996449444|OK||2017-05-11 17:38:18|verizon wireless:6006 - svr/2")

      Net::HTTP.stub :post_form, mocked_reponse do
        result = Slybroadcast::Client.campaign_status({})
        assert_equal result.call[:status], "OK"
        assert_equal result.call[:session_id], "9996130985"
      end

    end

    it 'should raise Exceptions::InvalidCredentials' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "ERROR\nc_uid: required")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert_raises Slybroadcast::Exceptions::InvalidCredentials do
          Slybroadcast::Client.campaign_status({})
        end
      end

    end

  end

  describe 'campaign_pause' do

    it 'should return session ID' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "OK\nsession ID=123456")

      Net::HTTP.stub :post_form, mocked_reponse do
        result = Slybroadcast::Client.campaign_pause({})
        assert_equal result.session_id, "123456"
      end

    end

    it 'should raise Exceptions::SessionIdRequired' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "ERROR\nsession_id: required")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert_raises Slybroadcast::Exceptions::SessionIdRequired do
          Slybroadcast::Client.campaign_pause({})
        end
      end

    end

  end


  describe 'campaign_resume' do

    it 'should return session ID' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "OK\nsession ID=123456")

      Net::HTTP.stub :post_form, mocked_reponse do
        result = Slybroadcast::Client.campaign_resume({})
        assert_equal result.session_id, "123456"
      end

    end

    it 'should raise Exceptions::SessionIdRequired' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "ERROR\nsession_id: required")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert_raises Slybroadcast::Exceptions::SessionIdRequired do
          Slybroadcast::Client.campaign_resume({})
        end
      end

    end

  end

  describe 'campaign_cancel' do

    it 'should return session ID' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "OK\nsession ID=123456")

      Net::HTTP.stub :post_form, mocked_reponse do
        result = Slybroadcast::Client.campaign_cancel({})
        assert_equal result.session_id, "123456"
      end

    end

    it 'should raise Exceptions::SessionIdRequired' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "ERROR\nsession_id: required")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert_raises Slybroadcast::Exceptions::SessionIdRequired do
          Slybroadcast::Client.campaign_cancel({})
        end
      end

    end

  end

  describe 'account_message_balance' do

    it 'should return remaining messages' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "remaining messages=12345\npending messages=123")

      Net::HTTP.stub :post_form, mocked_reponse do
        result = Slybroadcast::Client.account_message_balance
        assert_equal result.remaining_messages, "12345"
        assert_equal result.pending_messages, "123"
      end

    end

    it 'should raise StandardError' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "ERROR")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert_raises StandardError do
          Slybroadcast::Client.account_message_balance
        end
      end

    end

  end

  describe 'download_audio_file' do

    it 'should raise StandardError' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "ERROR")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert_raises StandardError do
          Slybroadcast::Client.download_audio_file
        end
      end

    end

  end

  describe 'list_audio_files' do

    it 'should return a list' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "\"r15294b17042522420232165.wav\"|\"123456\"|\"2017-04-25 22:42:25\"\n\"b15294b187575.wav\"|\"recording20160425-31049-1mq2hk7\"|\"2017-05-03 20:39:11\"")

      Net::HTTP.stub :post_form, mocked_reponse do
        result = Slybroadcast::Client.list_audio_files
        assert_equal result.success?, true
        assert_equal result.list.count, 2
      end

    end

    it 'should raise Exceptions::InvalidCredentials' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "ERROR\nc_uid: required")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert_raises Slybroadcast::Exceptions::InvalidCredentials do
          Slybroadcast::Client.list_audio_files
        end
      end

    end

  end

end
