module UrlHelper
  def url_without_protocol(url)
    return '' unless url.present?
    a = Addressable::URI.parse url
    buffer = a.host + a.path

    buffer = buffer.slice 0, buffer.length - 1 if buffer.ends_with? '/'

    buffer
  end
end
