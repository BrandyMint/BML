require 'rails_helper'

RSpec.describe Tariff, type: :model do
  subject { create :tariff }

  it { expect(subject).to be_persisted }
end
