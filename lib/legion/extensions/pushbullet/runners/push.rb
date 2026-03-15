# frozen_string_literal: true

module Legion
  module Extensions
    module Pushbullet
      module Runners
        module Push
          def send_note(title:, body:, device_iden: nil, email: nil, channel_tag: nil, **) # rubocop:disable Metrics/ParameterLists
            payload = { type: 'note', title: title, body: body }
            payload[:device_iden] = device_iden if device_iden
            payload[:email]       = email       if email
            payload[:channel_tag] = channel_tag if channel_tag
            resp = connection(**).post('pushes', payload)
            { push: resp.body }
          end

          def send_link(title:, url:, body: nil, device_iden: nil, email: nil, **) # rubocop:disable Metrics/ParameterLists
            payload = { type: 'link', title: title, url: url }
            payload[:body]        = body        if body
            payload[:device_iden] = device_iden if device_iden
            payload[:email]       = email       if email
            resp = connection(**).post('pushes', payload)
            { push: resp.body }
          end

          def send_file(file_name:, file_url:, file_type:, body: nil, device_iden: nil, **) # rubocop:disable Metrics/ParameterLists
            payload = { type: 'file', file_name: file_name, file_url: file_url, file_type: file_type }
            payload[:body]        = body        if body
            payload[:device_iden] = device_iden if device_iden
            resp = connection(**).post('pushes', payload)
            { push: resp.body }
          end

          def list_pushes(modified_after: nil, limit: nil, **)
            params = {}
            params[:modified_after] = modified_after if modified_after
            params[:limit]          = limit          if limit
            resp = connection(**).get('pushes', params)
            { pushes: resp.body }
          end

          def delete_push(iden:, **)
            connection(**).delete("pushes/#{iden}")
            { deleted: true, iden: iden }
          end

          def dismiss_push(iden:, **)
            resp = connection(**).post("pushes/#{iden}", { dismissed: true })
            { push: resp.body }
          end
        end
      end
    end
  end
end
