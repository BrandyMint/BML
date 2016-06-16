require 'openbill/migration'
class RemigrateOpenbill < ActiveRecord::Migration
  include Openbill::Migration

  def change
    openbill_reset
  end
end
