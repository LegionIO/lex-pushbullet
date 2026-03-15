# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Pushbullet
      module Helpers
        module Client
          def connection(token: nil, **_opts)
            Faraday.new(url: 'https://api.pushbullet.com/v2') do |conn|
              conn.request :json
              conn.response :json, content_type: /\bjson$/
              conn.headers['Access-Token'] = token if token
              conn.adapter Faraday.default_adapter
            end
          end
        end
      end
    end
  end
end
