SeedTariffes.new.perform

a = Account.find_or_create_by ident: Account::ROOT_IDENT

a.update_attributes tariff: Tariff.free

l = a.landings.find_by_path('/') || a.landings.create!(title: 'Пример 1', path: '/')
l.collections.create!
v = l.variants.first || l.variants.create

SectionsUpdater.new(v, regenerate_uuid: true).update(LandingExamples::EXAMPLE1)

Billing.payments_source

# LandingVersion.find_each { |l| SectionsUpdater.new(l, LandingExamples::EXAMPLE1).update }
