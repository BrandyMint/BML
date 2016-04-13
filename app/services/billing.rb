# Namespace биллинга
module Billing
  NS = :system

  class << self
    private

    # Находит, или создает аккаунт с указанным именем
    #
    def account(path, details)
      # Создаем uri аккаунта из его названия
      uri = Openbill.generate_uri NS, path

      Openbill.get_account_by_uri(uri) ||
        Openbill.create_account(uri, details: details)
    end
  end
end
