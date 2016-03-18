require 'rails_helper'

RSpec.describe Landing, type: :model do
  let!(:account) { create :account }
  it 'Должна быть возможность создавать сразу несколько сайтов, путь у них устанавливается автоматически' do
    l = create :landing
    expect(l).to be_a Landing

    l2 = create :landing
    expect(l2).to be_a Landing

    l3 = create :landing
    expect(l3).to be_a Landing
  end
end
