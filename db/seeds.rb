# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#


a = Account.find_or_create_by id: 1

l = a.landings.find_or_create_by title: 'Пример 1'
v = l.versions.first || l.versions.create

SectionsUpdater.new(v, regenerate_uuid: true).update(LandingExamples::EXAMPLE1)

# LandingVersion.find_each { |l| SectionsUpdater.new(l, LandingExamples::EXAMPLE1).update }
