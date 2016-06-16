module AccountBilling
  extend ActiveSupport::Concern
  OPENBILL_PREFIX = 'client-'.freeze

  included do
    after_commit :billing_account, on: :create
  end

  delegate :amount, to: :billing_account

  def billing_account
    Openbill.service.get_or_create_account_by_key billing_account_ident,
                                                  category_id: Billing::CLIENTS_CATEGORY_ID,
                                                  details: billing_details,
                                                  meta: { url: url, account_id: id }
  end

  def billing_transactions
    Openbill.service.account_transactions billing_account
  end

  def needs_recurrent_charge?
    has_debt? && payment_accounts.any?
  end

  # rubocop:disable Style/PredicateName
  def has_debt?
    amount.to_i < 0
  end

  private

  def billing_details
    [name.presence, ident].join ' '
  end

  def billing_account_ident
    OPENBILL_PREFIX + id.to_s
  end
end
