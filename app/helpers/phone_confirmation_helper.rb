module PhoneConfirmationHelper
  def new_profile_phone_confirmation_url(params = {})
    fail 'Должен быть backurl' unless params.key? :backurl
    new_phone_confirmation_url params #.merge(subdomain: 'app')
  end
end
