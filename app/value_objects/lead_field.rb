# Поле со значением, ключем и в будущем с типом
class LeadField
  include Virtus.value_object
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper
  include TruncateHelper
  include UrlHelper

  values do
    attribute :key
    attribute :value
  end

  delegate :blank?, to: :value

  def empty?
    blank?
  end

  # TODO: Использовать презентатор типа
  def value_html
    return nil unless value.present?

    case key.to_sym
    when :referer
      truncate_url value
    when :email
      mail_to value, value
    when :phone
      tel_to value
    else
      if value.start_with? 'http://'
        truncate_url value
      else
        value
      end
    end
  end

  def title
    # TODO: Column.title
    I18n.t key, scope: [:lead, :attributes], default: key
  end

  def to_s
    "#{key}: #{value}"
  end
end
