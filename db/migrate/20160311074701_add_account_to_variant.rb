class AddAccountToVariant < ActiveRecord::Migration
  def change
    add_reference :variants, :account, index: true, foreign_key: true

    reversible do |dir|
      dir.up do
        execute(%(
          UPDATE variants v
          SET account_id = a.id
          FROM landings l, accounts a
          WHERE v.landing_id = l.id
          AND l.account_id = a.id
        ))
        change_column :variants, :account_id, :integer, null: false
      end
    end
  end
end
