module ApplicationHelper
  def human_boolean(value)
    value ? 'Да' : 'Нет'
  end

  def setup_editor_bml
    config = {
      postLeadUrl: post_lead_url,
      apiUrl: api_v1_url,
      apiKey: current_account.api_key,
      variantUuid: current_variant.uuid,
      exitUrl: editor_exit_url
    }
    javascript_tag "window.bmlConfig = #{config.to_json}"
  end

  def editor_exit_url
    params[:backurl] || account_landing_leads_url(variant.id)
  end

  def api_v1_url
    api_url + 'v1'
  end

  def post_lead_url
    leads_url subdomain: ''
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

  def site_variant_url(variant)
    if variant.is_a? Landing
      landing = variant
      variant = variant.default_variant
    else
      landing = variant.landing
    end

    landing.host + "?variant_id=#{variant.id}"
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
