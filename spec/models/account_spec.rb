require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { create :account }

  it do
    expect(subject).to be_persisted
  end
end
