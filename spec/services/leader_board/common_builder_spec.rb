require 'rails_helper'

RSpec.describe LeaderBoard::CommonBuilder, type: :model do
  let(:name0) { 'Олег' }
  let(:name1) { 'Василий' }
  let(:name2) { 'Валентин' }
  let(:result1) { 123 }
  let(:result2) { 456 }

  let(:division) { 'RedShell' }
  let(:event1) { 'ЗаданиеN1' }
  let(:event2) { 'ЗаданиеN2' }

  let!(:collection) { create :collection }

  let!(:lead2) { create :lead, :accepted, data: { division: division, event: event1, name: name1, score: result1 }, collection: collection }
  let!(:lead4) { create :lead, :accepted, data: { division: division, event: event2, name: name1, score: result2 }, collection: collection }

  subject { described_class.new(collection: collection).build }

  it { expect(subject).to be_a LeaderBoard::Results }
  it { expect(subject.events).to eq [described_class::COMMON_EVENT, event1, event2] }

  let(:table) { subject.tables.first }

  it { expect(subject.tables.count).to eq 3 }
  it { expect(table.event).to eq described_class::COMMON_EVENT }
  it { expect(table.records.count).to eq 1 }
  it { expect(table.records.first).to eq LeaderBoard::Record.new(title: name1, note: nil, score: result1 + result2, rank: 1) }
end
