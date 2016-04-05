# Используется для создания тарифов в db/seeds.rb
class SeedTariffes
  def perform
    create_base
    create_profi
    create_free
  end

  private

  def create_base
    create_tariff(
      Tariff::BASE_SLUG,
      title: 'Базовый',
      price_per_month: Money.new(0, :rub),
      price_per_site: Money.new(30_000, :rub),
      price_per_lead: Money.new(1000, :rub),
      free_days_count: 7,
      free_leads_count: 5
    )
  end

  def create_profi
    create_tariff(
      Tariff::PROFI_SLUG,
      title: 'Профи',
      price_per_month: Money.new(1_500_000, :rub),
      price_per_site: Money.new(0, :rub),
      price_per_lead: Money.new(1000, :rub)
    )
  end

  def create_free
    create_tariff(
      Tariff::FREE_SLUG,
      title: 'Бесплатный',
      price_per_month: Money.new(0, :rub),
      price_per_site: Money.new(0, :rub),
      price_per_lead: Money.new(0, :rub),
      hidden: true
    )
  end

  def create_tariff(slug, attributes)
    tariff = Tariff.find_by_slug(slug)
    return tariff if tariff

    Tariff.create! attributes.merge(slug: slug)
  end
end
