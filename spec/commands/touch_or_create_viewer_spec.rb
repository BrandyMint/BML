require 'rails_helper'
require 'uuid'

RSpec.describe TouchOrCreateViewer, type: :model do
  let(:viewer_uid) { UUID.generate }
  let(:landing_id) { create(:landing).id }
  let(:remote_ip) { '127.0.0.1' }
  let(:user_agent) { 'browser' }

  describe 'call' do
    subject do
      described_class.new(viewer_uid: viewer_uid, remote_ip: remote_ip, user_agent: user_agent, landing_id: landing_id)
    end

    before do
      Viewer.delete_all
    end

    it 'создает нового вьюера и обновляет старого' do
      subject.call

      expect(Viewer.count).to eq 1
      viewer = Viewer.last
      expect(viewer.uid).to eq viewer_uid
      expect(viewer.created_at).to eq viewer.updated_at

      last_viewer =  viewer
      last_updated_at = viewer.updated_at

      subject.call
      viewer = Viewer.first
      puts viewer.updated_at
      expect(viewer.uid).to eq viewer_uid
      expect(viewer.created_at).to eq last_viewer.created_at
      expect(viewer.updated_at).to_not eq last_updated_at
    end
  end
end

