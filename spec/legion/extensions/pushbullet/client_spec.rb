# frozen_string_literal: true

RSpec.describe Legion::Extensions::Pushbullet::Client do # rubocop:disable Metrics/BlockLength
  let(:mock_conn) { instance_double(Faraday::Connection) }

  before do
    allow(Faraday).to receive(:new).and_return(mock_conn)
  end

  describe '#initialize' do
    it 'stores token in opts' do
      client = described_class.new(token: 'test-token')
      expect(client.opts[:token]).to eq('test-token')
    end

    it 'accepts extra options' do
      client = described_class.new(token: 'tok', extra: 'val')
      expect(client.opts[:extra]).to eq('val')
    end
  end

  describe 'push operations' do # rubocop:disable Metrics/BlockLength
    let(:client) { described_class.new(token: 'test-token') }

    it 'sends a note' do
      allow(mock_conn).to receive(:post).with('pushes', hash_including(type: 'note')).and_return(
        double(body: { 'iden' => 'abc123' })
      )
      result = client.send_note(title: 'Hello', body: 'World')
      expect(result[:push]).to include('iden' => 'abc123')
    end

    it 'sends a note with optional fields' do
      allow(mock_conn).to receive(:post).with('pushes', hash_including(device_iden: 'dev1')).and_return(
        double(body: { 'iden' => 'abc123' })
      )
      result = client.send_note(title: 'Hello', body: 'World', device_iden: 'dev1')
      expect(result[:push]).to include('iden' => 'abc123')
    end

    it 'sends a link' do
      allow(mock_conn).to receive(:post).with('pushes', hash_including(type: 'link')).and_return(
        double(body: { 'iden' => 'link1' })
      )
      result = client.send_link(title: 'Check this', url: 'https://example.com')
      expect(result[:push]).to include('iden' => 'link1')
    end

    it 'sends a file' do
      allow(mock_conn).to receive(:post).with('pushes', hash_including(type: 'file')).and_return(
        double(body: { 'iden' => 'file1' })
      )
      result = client.send_file(file_name: 'photo.jpg', file_url: 'https://example.com/photo.jpg', file_type: 'image/jpeg')
      expect(result[:push]).to include('iden' => 'file1')
    end

    it 'lists pushes' do
      allow(mock_conn).to receive(:get).with('pushes', {}).and_return(
        double(body: { 'pushes' => [] })
      )
      result = client.list_pushes
      expect(result[:pushes]).to include('pushes' => [])
    end

    it 'lists pushes with modified_after' do
      allow(mock_conn).to receive(:get).with('pushes', { modified_after: 1_000_000 }).and_return(
        double(body: { 'pushes' => [] })
      )
      result = client.list_pushes(modified_after: 1_000_000)
      expect(result[:pushes]).to include('pushes' => [])
    end

    it 'deletes a push' do
      allow(mock_conn).to receive(:delete).with('pushes/abc123').and_return(double(body: nil))
      result = client.delete_push(iden: 'abc123')
      expect(result[:deleted]).to be true
      expect(result[:iden]).to eq('abc123')
    end

    it 'dismisses a push' do
      allow(mock_conn).to receive(:post).with('pushes/abc123', { dismissed: true }).and_return(
        double(body: { 'dismissed' => true })
      )
      result = client.dismiss_push(iden: 'abc123')
      expect(result[:push]).to include('dismissed' => true)
    end
  end

  describe 'device operations' do
    let(:client) { described_class.new(token: 'test-token') }

    it 'lists devices' do
      allow(mock_conn).to receive(:get).with('devices').and_return(
        double(body: { 'devices' => [] })
      )
      result = client.list_devices
      expect(result[:devices]).to include('devices' => [])
    end

    it 'gets a device' do
      allow(mock_conn).to receive(:get).with('devices/dev1').and_return(
        double(body: { 'iden' => 'dev1', 'nickname' => 'My Phone' })
      )
      result = client.get_device(iden: 'dev1')
      expect(result[:device]).to include('iden' => 'dev1')
    end

    it 'creates a device' do
      allow(mock_conn).to receive(:post).with('devices', hash_including(nickname: 'My PC')).and_return(
        double(body: { 'iden' => 'dev2', 'nickname' => 'My PC' })
      )
      result = client.create_device(nickname: 'My PC')
      expect(result[:device]).to include('nickname' => 'My PC')
    end

    it 'updates a device' do
      allow(mock_conn).to receive(:post).with('devices/dev1', { nickname: 'New Name' }).and_return(
        double(body: { 'iden' => 'dev1', 'nickname' => 'New Name' })
      )
      result = client.update_device(iden: 'dev1', nickname: 'New Name')
      expect(result[:device]).to include('nickname' => 'New Name')
    end

    it 'deletes a device' do
      allow(mock_conn).to receive(:delete).with('devices/dev1').and_return(double(body: nil))
      result = client.delete_device(iden: 'dev1')
      expect(result[:deleted]).to be true
      expect(result[:iden]).to eq('dev1')
    end
  end

  describe 'channel operations' do
    let(:client) { described_class.new(token: 'test-token') }

    it 'lists subscriptions' do
      allow(mock_conn).to receive(:get).with('subscriptions').and_return(
        double(body: { 'subscriptions' => [] })
      )
      result = client.list_subscriptions
      expect(result[:subscriptions]).to include('subscriptions' => [])
    end

    it 'subscribes to a channel' do
      allow(mock_conn).to receive(:post).with('subscriptions', { channel_tag: 'mytag' }).and_return(
        double(body: { 'iden' => 'sub1', 'channel' => { 'tag' => 'mytag' } })
      )
      result = client.subscribe(channel_tag: 'mytag')
      expect(result[:subscription]).to include('iden' => 'sub1')
    end

    it 'unsubscribes from a channel' do
      allow(mock_conn).to receive(:delete).with('subscriptions/sub1').and_return(double(body: nil))
      result = client.unsubscribe(iden: 'sub1')
      expect(result[:deleted]).to be true
      expect(result[:iden]).to eq('sub1')
    end

    it 'gets channel info' do
      allow(mock_conn).to receive(:get).with('channel-info', { tag: 'mytag' }).and_return(
        double(body: { 'tag' => 'mytag', 'name' => 'My Channel' })
      )
      result = client.channel_info(tag: 'mytag')
      expect(result[:channel]).to include('tag' => 'mytag')
    end
  end
end
