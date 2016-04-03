module Importer
  def self.import(module_class)
    klass = Class.new
    klass.include module_class
    klass.new
  end
end
