# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/push'
require_relative 'runners/device'
require_relative 'runners/channel'

module Legion
  module Extensions
    module Pushbullet
      class Client
        include Helpers::Client
        include Runners::Push
        include Runners::Device
        include Runners::Channel

        attr_reader :opts

        def initialize(token:, **extra)
          @opts = { token: token, **extra }
        end

        def connection(**override)
          super(**@opts, **override)
        end
      end
    end
  end
end
