class AddDataStringToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :data_string, :text
  end
end
