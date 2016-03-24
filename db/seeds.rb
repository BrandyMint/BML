# Base
Tariff.create! title: 'Базовый',
               slug: Tariff::BASE_SLUG,
               price_per_month: Money.new(0, :rub),
               price_per_site: Money.new(30_000, :rub),
               price_per_lead: Money.new(1000, :rub),
               free_days_count: 7,
               free_leads_count: 5,
               hidden: false
# Profi
Tariff.create! title: 'Профи',
               slug: Tariff::PROFI_SLUG,
               price_per_month: Money.new(1_500_000, :rub),
               price_per_site: Money.new(0, :rub),
               price_per_lead: Money.new(1000, :rub),
               free_days_count: 0,
               free_leads_count: 0,
               hidden: false
# Root
root_tariff = Tariff.create! title: 'Root',
                             slug: Tariff::ROOT_SLUG,
                             price_per_month: Money.new(0, :rub),
                             price_per_site: Money.new(0, :rub),
                             price_per_lead: Money.new(0, :rub),
                             free_days_count: 0,
                             free_leads_count: 0,
                             hidden: true

a = Account.find_or_create_by ident: Account::ROOT_IDENT, tariff: root_tariff

l = a.landings.find_or_create_by title: 'Пример 1', path: '/'
l.collections.create!
v = l.variants.first || l.variants.create

SectionsUpdater.new(v, regenerate_uuid: true).update(LandingExamples::EXAMPLE1)

Billing.payments_source

# LandingVersion.find_each { |l| SectionsUpdater.new(l, LandingExamples::EXAMPLE1).update }
