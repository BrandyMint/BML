class AddUuidToLandings < ActiveRecord::Migration
  def up
    execute('CREATE EXTENSION IF NOT EXISTS "uuid-ossp"');

    execute('alter table landings add column uuid uuid not null default uuid_generate_v4()');
    execute('alter table landing_versions add column uuid uuid not null default uuid_generate_v4()');
    execute('alter table sections alter uuid set default uuid_generate_v4()');

    add_index :landings, [:uuid], unique: true
    add_index :landing_versions, [:uuid], unique: true
    add_index :sections, [:uuid], unique: true
  end

  def down
    remove_column :landings, :uuid
    remove_column :landing_versions, :uuid
  end
end
