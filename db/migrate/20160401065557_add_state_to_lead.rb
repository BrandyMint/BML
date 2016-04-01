class AddStateToLead < ActiveRecord::Migration
  def change
    add_column :leads, :state, :string, null: false, default: :new
  end
end
