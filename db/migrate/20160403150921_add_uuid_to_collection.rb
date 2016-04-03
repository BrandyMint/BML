class AddUuidToCollection < ActiveRecord::Migration
  TABLES = %i[accounts collections leads collection_fields]

  def up
    TABLES.each do |table|
      execute("alter table #{table} add column uuid uuid not null default uuid_generate_v4()");
    end
  end

  def down
    TABLES.each do |table|
      remove_column table, :uuid
    end
  end
end
