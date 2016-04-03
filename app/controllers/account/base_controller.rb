class Account::BaseController < ApplicationController
  include AuthorizeUser
  include AuthorizeMember
  include AuthorizeAccount
end
