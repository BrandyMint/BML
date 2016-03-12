require 'rails_helper'
require 'uuid'

RSpec.describe Viewer, type: :model do

  describe 'touch_or_create' do
    let(:viewer_uid) { UUID.generate }

    before do
      Viewer.delete_all
    end

    it 'создает нового вьюера и обновляет старого' do
      Viewer.touch_or_create viewer_uid

      expect(Viewer.count).to eq 1
      viewer = Viewer.last
      expect(viewer.uid).to eq viewer_uid
      expect(viewer.created_at).to eq viewer.updated_at

      last_viewer =  viewer
      last_updated_at = viewer.updated_at

      Viewer.touch_or_create viewer_uid
      viewer = Viewer.first
      puts viewer.updated_at
      expect(viewer.uid).to eq viewer_uid
      expect(viewer.created_at).to eq last_viewer.created_at
      expect(viewer.updated_at).to_not eq last_updated_at
    end
  end
end
