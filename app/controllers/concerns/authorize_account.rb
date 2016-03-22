module AuthorizeAccount
  extend ActiveSupport::Concern

  included do
    before_action :exists_account
  end

  private

  def exists_account
    raise NoCurrentAccount unless current_account.present?
  end
end
