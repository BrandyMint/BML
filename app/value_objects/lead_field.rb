# Поле со значением, ключем и в будущем с типом
class LeadField
  include Virtus.value_object
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper
  include TruncateHelper
  include HumanHelper
  include UrlHelper

  values do
    attribute :column, Column
    attribute :key, Symbol
    attribute :value
  end

  delegate :blank?, to: :value

  def empty?
    blank?
  end

  # TODO: Использовать презентатор типа
  def value_html
    case key.to_sym
    when :referer
      return nil unless value.present?
      truncate_url value
    when :email
      return nil unless value.present?
      mail_to value, value
    when :phone
      return nil unless value.present?
      tel_to value
    else
      other_value_html
    end
  end

  def title
    # TODO: Column.title
    I18n.t key, scope: [:lead, :attributes], default: key
  end

  def to_s
    "#{key}: #{value}"
  end

  private

  def other_value_html
    if value.start_with? 'http://'
      return nil unless value.present?
      truncate_url value
    elsif key.to_s.starts_with?('is_')
      human_boolean value.to_i == 1
    else
      value
    end
  end
end
