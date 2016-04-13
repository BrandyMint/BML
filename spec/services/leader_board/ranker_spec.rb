require 'rails_helper'

RSpec.describe LeaderBoard::Ranker, type: :model do
  let(:input_results) do
    [
      {
        records: [
          { score: nil, title: 'Вася' },
          { score: '12', title: 'Петя' },
          { score: nil, title: 'Николай' },
          { score: '12', title: 'Брат Пети' },
          { score: '23', title: 'Серёжа' }
        ]
      }
    ]
  end

  let(:output_results) do
    [
      {
        records: [
          { score: '12', title: 'Петя', rank: 1 },
          { score: '12', title: 'Брат Пети', rank: 1 },
          { score: '23', title: 'Серёжа', rank: 2 },
          { score: nil,  title: 'Вася', rank: 0 },
          { score: nil, title: 'Николай', rank: 0 }
        ]
      }
    ]
  end

  subject { described_class.new(results: input_results).rank! }

  it { expect(subject).to match output_results }
end
