# Попытка реализовать import а-ля es6
#
# importer на входе принимает название модуля. Создает абстрактный класс, инклюдит в него
# модуль и отдает инстанс. Типовое использование:
#
#
# Helpers = Importer.import TextHelper
#
# Helpers.truncate('text')
module Importer
  def self.import(module_class)
    klass = Class.new
    klass.include module_class
    klass.new
  end
end
