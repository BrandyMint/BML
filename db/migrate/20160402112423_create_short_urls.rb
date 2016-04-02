class CreateShortUrls < ActiveRecord::Migration
  def up
    create_table :short_urls do |t|
      t.string :url, null: false
      t.string :secret_key, null: false

      t.timestamps null: false
    end

    execute 'alter table short_urls alter column created_at set default now()'
    execute 'alter table short_urls alter column updated_at set default now()'

    add_index :short_urls, [:url], unique: true
  end

  def down
    drop_table :short_urls
  end
end
