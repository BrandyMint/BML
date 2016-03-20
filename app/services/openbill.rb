require 'singleton'

module Openbill
  ACCOUNTS_TABLE_NAME     = :openbill_accounts
  TRANSACTIONS_TABLE_NAME = :openbill_transactions

  class << self
    attr_writer :current

    delegate :create_account, :get_account_by_uri, :make_transaction, to: :current

    def generate_uri(resource, id)
      "obp://local/#{resource}/#{id}"
    end

    def current
      @current || raise('No current Openbill Service initialized')
    end
  end
end
