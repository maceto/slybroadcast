module Slybroadcast
  module Exceptions

    class InvalidCredentials < ::ArgumentError
    end

    class BadAudio < ::TypeError
    end

    class CampaignNotFound < ::RuntimeError
    end

    class CampaignAlreadyFinished < ::RuntimeError
    end

    class SessionIdRequired < ::ArgumentError
    end

  end
end
