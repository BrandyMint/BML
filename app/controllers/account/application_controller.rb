class Account::ApplicationController < ApplicationController
  include CurrentAccount
  include CurrentAccountSupport
  include MessageVerifierConcern

  layout 'account'
end
