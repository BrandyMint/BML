require 'rails_helper'

RSpec.describe LeaderBoard::Ranker, type: :model do
  let(:input_records) do
    [
      { score: nil, title: 'Вася' },
      { score: '12', title: 'Петя' },
      { score: nil, title: 'Николай' },
      { score: '12', title: 'Брат Пети' },
      { score: '23', title: 'Серёжа' }
    ]
  end

  let(:output_records) do
    [
      { score: '23', note: nil, title: 'Серёжа', rank: 1 },
      { score: '12',  note: nil, title: 'Петя', rank: 2 },
      { score: '12',  note: nil, title: 'Брат Пети', rank: 2 },
      { score: nil,   note: nil, title: 'Вася', rank: 0 },
      { score: nil,  note: nil, title: 'Николай', rank: 0 }
    ].map { |record| LeaderBoard::Record.new record }
  end

  subject { described_class.new(records: input_records).rank }

  it { expect(subject.as_json).to match output_records.as_json }
end
