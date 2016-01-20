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

v.sections.find_or_create_by uuid: 'section1', block_type: 'LBlockHeader', block_view: 'LBlockHeaderV1'
v.sections.find_or_create_by uuid: 'section2', block_type: 'LBlockHeader', block_view: 'LBlockHeaderV2'
v.sections.find_or_create_by uuid: 'section3', block_type: 'LBlockHeader', block_view: 'LBlockHeaderV1'
