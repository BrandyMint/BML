# encoding: utf-8
class OmniauthController < Account::ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  def create
    oa.authentificate

    redirect_to back_url, flash: { success: I18n.t('flashes.sessions.created') }

  rescue OAuth2::Error => e
    Bugsnag.notify e,
      metaData: {
        account_id: omniauth_account.id,
        auth_hash: auth_hash,
        session: session }
    redirect_to back_url, flash: { error: I18n.t('flashes.sessions.unknown_error') }
  end

  def failure
    page = ErrorPage.build :auth_failure
    render(
      'auth_failure',
      status: 401,
      locals: { current_page: page },
      layout: 'errors',
      formats: 'html'
    )
  end

  protected

  def back_url
    request.env['omniauth.origin'] || account_dashboard_url
  end

  def account_dashboard_url
    auth_account.operator_url + operator_account_deliveries_path
  end

  def oa
    OmniauthAuthenticator.new auth_hash: auth_hash, account: omniauth_account
  end

  def omniauth_account
    # TODO take account from session
    Account.first
  end

  def find_omniauth_account
    id, _time = message_verifier.verify(request.env['omniauth.params']['account_signature'])
    Account.find id
  rescue => err
    Bugsnag.notify err, metaData: auth_hash, env: env
    raise err
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
