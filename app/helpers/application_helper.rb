module ApplicationHelper
  def setup_public_bml
    config = {
      postLeadUrl: post_lead_url,
      apiUrl: api_v1_url,
      apiKey: current_account.try(:api_key)
    }
    javascript_tag "window.bmlConfig = #{config.to_json}"
  end

  def setup_editor_bml
    config = {
      postLeadUrl: post_lead_url,
      apiUrl: api_v1_url,
      apiKey: current_account.api_key
    }
    javascript_tag "window.bmlConfig = #{config.to_json}"
  end

  def api_v1_url
    api_url + 'v1'
  end

  def application
    OpenStruct.new Settings.app
  end

  def paginate(objects, options = {})
    options.reverse_merge! theme: 'twitter-bootstrap-4'
    super objects, options
  end

  def omniauth_button(provider, title: nil)
    # link_to "/auth/#{provider}/?account_signature=#{account_signature}", class: 'btn btn-success btn-rounded' do
    link_to "/auth/#{provider}", class: 'btn btn-success btn-rounded' do
      fa_icon provider, text: title || t(provider, scope: 'operator.omniauth_buttons')
    end
  end

  def site_landing_version_url(landing_version)
    if landing_version.is_a? Landing
      landing = landing_version
      landing_version = landing_version.default_version
    else
      landing = landing_version.landing
    end

    landing.host + "?version_id=#{landing_version.id}"
  end

  def tel_to(tel, opts = {})
    number = begin
               pn = Phoner::Phone.parse tel
               pn.to_s
             rescue
               tel
             end
    link = "tel:#{number}"
    opts = opts.reverse_merge class: 'tel-link', href: link
    content_tag :a, tel, opts
  end

  def account_dashboard_url(account)
    account_root_url(subdomain: account.subdomain)
  end

  def add_landing_image_url
    'http://dsp.io/assets/images/icons/plus-512.png'
  end

  def fallback_image_url
    'http://i0.wp.com/modernweb.com/wp-content/uploads/2013/07/fallback_header.jpg?fit=320%2C400'
  end
end
