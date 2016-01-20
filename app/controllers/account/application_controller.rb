class Account::ApplicationController < ApplicationController
  include CurrentAccountSupport

  layout 'account'
end
