class ErrorPage < Page
  attribute :subject
  attribute :content

  def self.build(key)
    new title:   I18n.t(:title, scope: [:error_page, key], default: ''),
        subject: I18n.t(:subject, scope: [:error_page, key], default: key.to_s).html_safe,
        content: I18n.t(:content_html, scope: [:error_page, key], default: '').html_safe
  end

  def self.build_from_humanized(error)
    new title: error.title, subject: error.title, content: error.message
  end

  def self.build_from_error(error)
    new title: error.class, subject: error.class, content: error.message
  end
end
