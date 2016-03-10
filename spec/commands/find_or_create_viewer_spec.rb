require 'rails_helper'

RSpec.describe FindOrCreateViewer do
  let(:uid) { 'xxx' }

  subject { described_class.new(uid: uid) }

  describe '#call' do
    context 'new viewer' do
      before { subject.call }
      it 'must create viewer' do
        expect(Viewer.find_by_uid(uid)).to be_a Viewer
      end
    end

    context 'viewer exists' do
      let!(:viewer) { create :viewer }
      let(:uid) { viewer.uid }
      let(:updated_at) { viewer.updated_at.dup }
      before do
        subject.call
      end
      it 'must touch viewer' do
        expect(Viewer.find_by_uid(uid).updated_at).not_to eq updated_at
        expect(Viewer.count).to eq 1
      end
    end
  end
end
