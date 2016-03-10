class CreateViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|
      t.string :uid, null: false

      t.timestamps null: false
    end

    add_index :viewers, :uid, unique: true
    execute('alter table viewers alter uid set default uuid_generate_v4()')
  end
end
