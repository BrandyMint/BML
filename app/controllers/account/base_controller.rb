class Account::BaseController < ApplicationController
  include AuthorizeUser
  NotAuthenticated = Class.new StandardError
  NoCurrentAccount = Class.new StandardError

  layout 'account'

  before_action :exists_account
  before_action :authorize_member

  private

  def exists_account
    fail NoCurrentAccount unless current_account.present?
  end

  def authorize_member
    fail NotAuthenticated unless current_member.present?
  end
end
