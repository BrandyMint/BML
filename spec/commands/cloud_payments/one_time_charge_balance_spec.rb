require 'rails_helper'

describe CloudPayments::OneTimeChargeBalance, vcr: true, openbill: true do
  let!(:account)            { create :account, :with_billing }
  let!(:amount_cents)       { '50,53' }
  let!(:amount_currency)    { account.billing_account.amount_currency }
  let!(:recurrent)          { false }
  let!(:ip)                 { '127.0.0.1' }
  let!(:valid_token)        { '9BBEF19476623CA56C17DA75FD57734DBF82530686043A6E491C6D71BEFE8F6E' }
  let!(:valid_cryptogram)   { '014111111111300102YuIPFdq6K1UyfGW7jbb1HBrusFlHRX6nnyGURZxWyCElYbie5GOLwNnqGZObJzySoqD8A4b5pyG9Yp5l4MENkQ+TvWJun/yrX7t/jscGFJNyPMIwxQh1/fDnBlN4CVNoaIBJ5NcpDJyTDsV/LJC4PyhL4trVmVaCWoTxwpESVifGLpos3BouUp/0FWWy1y7UlFkW8x3ilaDAdQkXZBC7KF6fpn30kOOhZpmTqlls6n0Oy1B/4Mg+/I1oj52MxXs7ir+IShVgIZ/saZaN6i46bObQsyzeKKGUEXhzdwAJQbPKM9C/qnRBXZGUah3/ZhJfMKSMK3sf1cNo/qQsFN83Og==' }
  let!(:invalid_cryptogram) { '014000055556300102EMIbsAAV/khfFkic0MkBFubqUc/yS8LaTB6QEyIX2NdnLXDcLGlOYQf3HgcvewC0NX2cJMnFJUM27aT/IevrhrtTclmUUyALFvfzSqsEY+X9hWzdCPvEuz7Aur7Xdb3W3NarP0uyGnvzZ431h7oJf0L2h28Z7CZYt+J3a8dCIrsi1QkAWbOrdix5KK34fdnNNtp6nio1AISv0FHipfANhuhVa0zOBYl8chXld+Ns8yT4tJMU+6WnMulw26J+hg+jIZOCfQTYa561wo5UVIkdeGnXNIrYA1zJ8LWjpOb+C2YtgatEVmVDUztvWgF9pb4lOnupf6oiB89hhNFo9plYIQ==' }
  let(:params)              do
    { amount_cents: amount_cents,
      amount_currency: amount_currency,
      name: 'CARDHOLDER NAME',
      recurrent: recurrent,
      cryptogram_packet: cryptogram_packet,
      currency_iso_code: account.currency_iso_code }
  end
  let(:form) { BalancePaymentForm.new params }

  subject do
    described_class.new(account: account,
                        form: form, ip: ip)
  end

  describe '#call' do
    context 'w/ valid params' do
      let(:cryptogram_packet) { valid_cryptogram }

      it 'must not raise error' do
        expect { subject.call }.not_to raise_error
      end

      context 'payment accounts' do
        context 'form.recurrent = true' do
          let(:recurrent) { true }

          context 'w/out payment account' do
            before { subject.call }
            it 'must create new payment account' do
              expect(account.payment_accounts.count).to eq 1
              expect(account.payment_accounts.last.token).to eq valid_token
            end
          end

          context 'w/ payment account present' do
            let(:payment_account) { create :payment_account, account: account, token: valid_token }
            before { subject.call }
            it 'must not create payment account' do
              expect(account.payment_accounts.count).to eq 1
              expect(account.payment_accounts.last.token).to eq valid_token
            end
          end
        end

        context 'form.recurrent = false' do
          before { subject.call }
          it 'must not create payment account' do
            expect(account.payment_accounts.count).to eq 0
          end
        end
      end

      context 'balance' do
        before { subject.call }
        it 'must charge' do
          expect(Openbill::Transaction.count).to eq 1
          expect(account.billing_account.amount).to eq Money.new(5053, account.billing_account.amount_currency)
        end
      end
    end

    context 'w/ invalid params' do
      let(:cryptogram_packet) { valid_cryptogram }
      let(:amount_cents) { -100 }
      it 'must raise error' do
        expect { subject.call }.to raise_error(described_class::InvalidForm)
      end
    end

    context 'w/ banking errors (InsufficientFunds)' do
      let(:cryptogram_packet) { invalid_cryptogram }
      it 'must raise CloudPaymentsError' do
        expect { subject.call }.to raise_error(CloudPaymentsError, I18n.t('errors.humanized.cloud_payments_error.InsufficientFunds'))
      end
    end
  end
end
