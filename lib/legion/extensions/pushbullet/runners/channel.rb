# frozen_string_literal: true

module Legion
  module Extensions
    module Pushbullet
      module Runners
        module Channel
          def list_subscriptions(**)
            resp = connection(**).get('subscriptions')
            { subscriptions: resp.body }
          end

          def subscribe(channel_tag:, **)
            resp = connection(**).post('subscriptions', { channel_tag: channel_tag })
            { subscription: resp.body }
          end

          def unsubscribe(iden:, **)
            connection(**).delete("subscriptions/#{iden}")
            { deleted: true, iden: iden }
          end

          def channel_info(tag:, **)
            resp = connection(**).get('channel-info', { tag: tag })
            { channel: resp.body }
          end
        end
      end
    end
  end
end
