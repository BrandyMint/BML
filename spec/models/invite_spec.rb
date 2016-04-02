require 'rails_helper'

RSpec.describe Invite, type: :model do
  subject { create :invite }

  it { expect(subject).to be_a described_class }
end
