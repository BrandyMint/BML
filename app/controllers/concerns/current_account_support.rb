module CurrentAccountSupport
  extend ActiveSupport::Concern
  include CurrentAccount

  included do
    helper_method :current_account
  end
end
