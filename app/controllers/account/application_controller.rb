class Account::ApplicationController < ApplicationController
  include CurrentAccount
  include CurrentAccountSupport
  include CurrentMember
  include CurrentMemberSupport
  include MessageVerifierConcern

  layout 'account'
end
