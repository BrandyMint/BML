require 'rails_helper'

RSpec.describe LeaderBoard::Builder, type: :model do
  let(:division) { 'RedShell' }
  let(:event) { 'ЗаданиеN1' }
  let!(:collection) { create :collection }
  let!(:lead1) { create :lead, collection: collection }
  let!(:lead2) { create :lead, :accepted, data: { division: division, event: event, name: name1, score: result1 }, collection: collection }
  let!(:lead3) { create :lead, :accepted, data: { division: division, event: event, name: name2, score: result2 }, collection: collection }

  let(:name1) { 'Василий' }
  let(:name2) { 'Валентин' }
  let(:result1) { '123' }
  let(:result2) { '456' }

  let(:results) do
    {
      divisions: [division],
      events: [event],
      tables:
        [
          {
            division: division,
            event: event,
            sex: 'male',
            records: [
              { title: name1, note: nil, score: result1.to_i, rank: 1 },
              { title: name2, note: nil, score: result2.to_i, rank: 2 }
            ]
          }
        ]
    }
  end

  subject { described_class.new(collection: collection).build }

  it { expect(subject).to match results }
end
