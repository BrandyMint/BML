require 'rails_helper'

describe CloudPayments::OneTimePayment, vcr: true do
  let!(:account)            { create :account, :with_billing }
  let!(:amount_cents)       { '50,53' }
  let!(:amount_currency)    { account.billing_account.amount_currency }
  let!(:recurrent)          { false }
  let!(:ip)                 { '127.0.0.1' }
  let!(:valid_token)        { '9BBEF19476623CA56C17DA75FD57734DBF82530686043A6E491C6D71BEFE8F6E' }
  let!(:valid_cryptogram)   { '014111111111300102YuIPFdq6K1UyfGW7jbb1HBrusFlHRX6nnyGURZxWyCElYbie5GOLwNnqGZObJzySoqD8A4b5pyG9Yp5l4MENkQ+TvWJun/yrX7t/jscGFJNyPMIwxQh1/fDnBlN4CVNoaIBJ5NcpDJyTDsV/LJC4PyhL4trVmVaCWoTxwpESVifGLpos3BouUp/0FWWy1y7UlFkW8x3ilaDAdQkXZBC7KF6fpn30kOOhZpmTqlls6n0Oy1B/4Mg+/I1oj52MxXs7ir+IShVgIZ/saZaN6i46bObQsyzeKKGUEXhzdwAJQbPKM9C/qnRBXZGUah3/ZhJfMKSMK3sf1cNo/qQsFN83Og==' }
  let!(:secure3d_cryptogram) { '015555554444300102fX/p02zlCZ6AVp0qFCZjjpPYgn2onXRGxnWo/Q6mQ0+pmqk172hzlq9TWRXOQd3U9gjYDARFBfavt4/njJL+25mONlmI+VtSN8f8Mv9md+FXQ+p436jAPoHO2PPP67R+w7yjxq4tCNUsc7zf0+V/7U9v0J0ZBc0xaTVK+r4Mf5Fd2Z49DTISWhEksc5RX/FHf2gh1GaM5UCsTMpwoO39wKqG//XtD+S7QXqNeVzkEMsvasdgl1vhxtmP94KG10ZA30D8FbtalpaaE1d595ao2kRIrlUDe1499A24bVKMne8adZb2GDV/m3B5fT+jGN/jnoiwMqZodMKdUvsiv4V9IQ==' }
  let!(:invalid_cryptogram) { '014000055556300102EMIbsAAV/khfFkic0MkBFubqUc/yS8LaTB6QEyIX2NdnLXDcLGlOYQf3HgcvewC0NX2cJMnFJUM27aT/IevrhrtTclmUUyALFvfzSqsEY+X9hWzdCPvEuz7Aur7Xdb3W3NarP0uyGnvzZ431h7oJf0L2h28Z7CZYt+J3a8dCIrsi1QkAWbOrdix5KK34fdnNNtp6nio1AISv0FHipfANhuhVa0zOBYl8chXld+Ns8yT4tJMU+6WnMulw26J+hg+jIZOCfQTYa561wo5UVIkdeGnXNIrYA1zJ8LWjpOb+C2YtgatEVmVDUztvWgF9pb4lOnupf6oiB89hhNFo9plYIQ==' }
  let(:params)              do
    { amount_cents: amount_cents,
      amount_currency: amount_currency,
      name: 'CARDHOLDER NAME',
      recurrent: recurrent,
      cryptogram_packet: cryptogram_packet
    }
  end
  let(:session) { {} }
  let(:form) { CloudPaymentsForm.new params }

  subject do
    described_class.new(session: session, account: account,
                        form: form, ip: ip)
  end

  describe '#call' do
    context 'w/ valid params' do
      let(:cryptogram_packet) { valid_cryptogram }

      it 'must not raise error' do
        expect(subject.call).to be_a CloudPayments::Transaction
      end

      context '3ds' do
        let(:cryptogram_packet) { secure3d_cryptogram }

        context 'form.recurrent = true' do
          let(:recurrent) { true }

          it 'must set recurrent flag' do
            expect { subject.call }.to raise_error Payments::Secure3dRedirect
            expect(session[Payments::CLOUDPAYMENTS_SAVE_CARD_KEY]).to eq true
          end
        end

        context 'form.recurrent = false' do
          it 'must not set recurrent flag' do
            expect { subject.call }.to raise_error Payments::Secure3dRedirect
            expect(session[Payments::CLOUDPAYMENTS_SAVE_CARD_KEY]).to eq false
          end
        end
      end
    end

    context 'w/ invalid params' do
      let(:cryptogram_packet) { valid_cryptogram }
      let(:amount_cents) { -100 }
      it 'must raise error' do
        expect { subject.call }.to raise_error(Payments::InvalidForm)
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
