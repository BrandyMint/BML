class Account::BaseController < ApplicationController
  include AuthorizeUser
  include AuthorizeMember
  include AuthorizeAccount

  layout 'account'
end
