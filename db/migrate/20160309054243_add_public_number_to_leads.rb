class AddPublicNumberToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :public_number, :string
    Lead.find_each do |l|
      l.send :generate_public_number
      l.update_column :public_number, l.public_number
    end

    change_column :leads, :public_number, :string, null: false

    add_reference :leads, :landing, foreign_key: true

    Lead.find_each do |l|
      l.update_column :landing_id, l.variant.landing_id
    end

    change_column :leads, :landing_id, :integer, null: false

    add_index :leads, [:landing_id, :public_number], unique: true
  end
end
