class Account::BaseController < ApplicationController
  include AuthorizeUser

  layout 'account'

  before_action :exists_account
  before_action :authorize_member

  private

  def exists_account
    raise NoCurrentAccount unless current_account.present?
  end

  def authorize_member
    raise NotAuthorized unless current_member.present?
  end
end
