class AddPublicNumberToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :public_number, :string
    change_column :leads, :public_number, :string, null: false

    add_reference :leads, :landing, foreign_key: true

    change_column :leads, :landing_id, :integer, null: false

    add_index :leads, [:landing_id, :public_number], unique: true
  end
end
