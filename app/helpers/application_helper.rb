module ApplicationHelper
  def landing_editor_path(landing, version)
    account_landing_editor_path(landing, version_id: version.try(:id) || landing.default_version.id)
  end

  def site_landing_version_url(landing_version)
    landing_version = landing_version.default_verison if landing_version.is_a? Landing

    site_landing_path landing_version.landing, version_id: landing_version.id
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

  def account_home_url(account)
    account_root_url(subdomain: account.subdomain)
  end

  def add_landing_image_url
    'http://dsp.io/assets/images/icons/plus-512.png'
  end

  def fallback_image_url
    'http://i0.wp.com/modernweb.com/wp-content/uploads/2013/07/fallback_header.jpg?fit=320%2C400'
  end
end
