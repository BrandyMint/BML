module TitleWithCountHelper
  def title_with_count(title, count = 0)
    buffer = title
    buffer << content_tag(:span, " (#{count})", class: 'text-muted') unless count.blank?
    buffer.html_safe
  end
end
