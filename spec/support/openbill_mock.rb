module OpenbillMock
  def stub_openbill
    service = double
    account = OpenStruct.new amount: Money.new(0, :rub), amount_currency: 'rub'
    allow(service).to receive(:get_or_create_account_by_key).and_return account
    allow(service).to receive(:get_account).and_return account
    allow(Openbill).to receive(:service).and_return service
  end
end
