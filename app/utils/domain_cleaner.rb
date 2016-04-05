# rubocop:disable Style/ModuleFunction
# Функции для нормализации доменов и субдоменов
module DomainCleaner
  extend self

  def prepare_subdomain(domain)
    slug truncate basic_cleanup transliterate domain
  end

  def save_prepare(domain)
    SimpleIDN.to_ascii basic_cleanup domain
  end

  def search_prepare(domain)
    SimpleIDN.to_unicode basic_cleanup domain
  end

  private

  def basic_cleanup(domain)
    unwww downcase unspace domain
  end

  def slug(str)
    str.gsub(/[^a-z0-9_\-]+/, '').gsub(/(--+)/, '-')
  end

  def truncate(str)
    str[0..(WebAddress::SUBDOMAIN_MAX_LENGTH - 3)]
  end

  def transliterate(str)
    str.to_slug.normalize(transliterations: [:russian]).to_s
  end

  def unwww(str)
    str.to_s.sub(/^www\./, '')
  end

  def downcase(str)
    str.to_s.mb_chars.downcase.to_s
  end

  def unspace(str)
    str.to_s.squish!.tr(' ', '')
  end
end
