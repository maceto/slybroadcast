require_relative "helper"

describe Slybroadcast::Client do
  describe 'verify' do

    it 'should be true' do

      class MockResponse
        def self.body
          'OK'
        end
      end

      mock = MiniTest::Mock.new
      mock.expect(:post_form, MockResponse, [{c_uid: 'user@example.com', c_password: 'secret' }])

      Net::HTTP.stub :post_form, mock.post_form({:c_uid=>"user@example.com", :c_password=>"secret"}) do
        result = Slybroadcast::Client.verify({})
        assert result
      end

    end

    it 'should be false' do

      class MockResponse
        def self.body
          'ERROR'
        end
      end

      mock = MiniTest::Mock.new
      mock.expect(:post_form, MockResponse, [{c_uid: 'user@example.com', c_password: 'secret' }])

      Net::HTTP.stub :post_form, mock.post_form({:c_uid=>"user@example.com", :c_password=>"secret"}) do
        assert_raises Slybroadcast::Exceptions::InvalidCredentials do
          result = Slybroadcast::Client.verify({})
        end
      end

    end

  end
end
