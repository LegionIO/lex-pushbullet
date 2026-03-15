# frozen_string_literal: true

module Legion
  module Extensions
    module Pushbullet
      module Runners
        module Device
          def list_devices(**)
            resp = connection(**).get('devices')
            { devices: resp.body }
          end

          def get_device(iden:, **)
            resp = connection(**).get("devices/#{iden}")
            { device: resp.body }
          end

          def create_device(nickname:, model: nil, manufacturer: nil, **)
            payload = { nickname: nickname }
            payload[:model]        = model        if model
            payload[:manufacturer] = manufacturer if manufacturer
            resp = connection(**).post('devices', payload)
            { device: resp.body }
          end

          def update_device(iden:, nickname: nil, **)
            payload = {}
            payload[:nickname] = nickname if nickname
            resp = connection(**).post("devices/#{iden}", payload)
            { device: resp.body }
          end

          def delete_device(iden:, **)
            connection(**).delete("devices/#{iden}")
            { deleted: true, iden: iden }
          end
        end
      end
    end
  end
end
