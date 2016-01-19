class Account::ApplicationController < ApplicationController
  include CurrentAccount
  layout 'account'
end
