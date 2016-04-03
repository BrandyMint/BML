module UrlHelper
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

  def url_without_protocol(url)
    return '' unless url.present?
    a = Addressable::URI.parse url
    buffer = a.host + a.path

    buffer = buffer.slice 0, buffer.length - 1 if buffer.ends_with? '/'

    buffer
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

  def account_dashboard_url(account)
    account_root_url(subdomain: account.default_web_address)
  end

  def add_landing_image_url
    'http://dsp.io/assets/images/icons/plus-512.png'
  end

  def fallback_image_url
    'http://i0.wp.com/modernweb.com/wp-content/uploads/2013/07/fallback_header.jpg?fit=320%2C400'
  end

  def truncate_url(url, length: 30)
    return unless url.present?
    buffer = truncate_middle url_without_protocol(url), length: length
    link_to buffer, url, title: url, target: '_blank', class: 'text-muted'
  end
end
