require_relative "helper"

describe Slybroadcast::Client do
  describe 'verify' do

    it 'should be true' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "OK")

      Net::HTTP.stub :post_form, mocked_reponse do
        result = Slybroadcast::Client.verify({})
        assert result
      end

    end

    it 'should be false' do

      mocked_reponse = MiniTest::Mock.new
      mocked_reponse.expect(:body, "ERROR")

      Net::HTTP.stub :post_form, mocked_reponse do
        assert_raises Slybroadcast::Exceptions::InvalidCredentials do
          result = Slybroadcast::Client.verify({})
        end
      end

    end

  end
end
