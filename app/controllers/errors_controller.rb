class ErrorsController < ApplicationController
  def site_not_found
    if reserved_domain?
      not_found
    else
      domain_not_found
    end
  end

  def error
    fail "Проверка ловли ошибок #{AppVersion}"
  end

  def not_found
    fail ActiveRecord::RecordNotFound
  end

  private

  def domain_not_found
    account = Account.find_by_suggested_domain request.host

    if account.present?
      account.attach_domain request.host
      redirect_to request.url
    else
      render 'no_account', layout: 'system/error', locals: { account: account }, formats: 'html', status: 404
    end
  end

  def reserved_domain?
    Settings.domain_zones.include? RequestProxy.new(request).domain
  end
end
