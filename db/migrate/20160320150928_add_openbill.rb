class AddOpenbill < ActiveRecord::Migration
  OPENBILL_DATABASE_FILE = Rails.root.join 'vendor/openbill/sql/db.sql'
  OPENBILL_DATABASE_SQL = File.read OPENBILL_DATABASE_FILE

  def up
    execute OPENBILL_DATABASE_SQL
  end

  def down
    execute "DROP TABLE openbill_accounts CASCADE"
    execute "DROP TABLE openbill_transactions CASCADE"
  end
end
