require 'rails_helper'

describe CloudPayments::Post3ds, vcr: true do
  let(:pa_res) { 'AQ==' }

  subject do
    described_class.new(md: md, pa_res: pa_res)
  end

  describe '#call' do
    context 'w/ valid params' do
      let(:md) { '2923695' }
      it 'must return response' do
        expect(subject.call).to be_a CloudPayments::Transaction
      end
    end

    context 'w/ invalid params' do
      let(:md) { '000' }
      it 'must raise error' do
        expect { subject.call }.to raise_error CloudPayments::Client::GatewayError
      end
    end

    context 'w/ banking errors (InsufficientFunds)' do
      let(:md) { '2923713' }
      it 'must raise CloudPaymentsError' do
        expect { subject.call }.to raise_error(CloudPaymentsError, I18n.t('errors.humanized.cloud_payments_error.InsufficientFunds'))
      end
    end
  end
end
