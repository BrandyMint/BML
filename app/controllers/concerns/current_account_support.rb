module CurrentAccountSupport
  extend ActiveSupport::Concern

  included do
    helper_method :current_account
  end
end
