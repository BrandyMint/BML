class ErrorsController < ApplicationController
  def site_not_found
    if reserved_domain?
      not_found
    else
      domain_not_found
    end
  end

  def error
    raise "Проверка ловли ошибок #{AppVersion}"
  end

  def not_found
    raise ActiveRecord::RecordNotFound
  end

  private

  def domain_not_found
    account = Account.find_by_suggested_domain(request.host)

    raise UnknownSite unless account.present?

    account.attach_domain request.host
    redirect_to request.url
  end

  def reserved_domain?
    Settings.domain_zones.include? RequestProxy.new(request).domain
  end
end
