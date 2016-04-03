class Account::EditorController < ApplicationController
  include AuthorizeUser

  layout 'editor'

  helper_method :current_variant, :current_account

  def show
    variant = find_variant
    account = variant.account

    raise NotAuthorized unless current_user.available_accounts.include? account

    @current_variant = variant
    @current_account = account
  end

  def redirect
    # TODO find account by url
    redirect_to account_root_url host: AppSettings.host
  end

  private

  attr_accessor :current_account, :current_variant

  def find_variant
    Variant.find_by_uuid(params[:uuid]) || raise(NoCurrentVariant)
  end
end
