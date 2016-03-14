a = Account.find_or_create_by ident: Account::ROOT_IDENT

l = a.landings.find_or_create_by title: 'Пример 1'
l.collections.create!
v = l.variants.first || l.variants.create

SectionsUpdater.new(v, regenerate_uuid: true).update(LandingExamples::EXAMPLE1)

# LandingVersion.find_each { |l| SectionsUpdater.new(l, LandingExamples::EXAMPLE1).update }
