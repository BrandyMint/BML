class AddDataStringToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :data_string, :text
    Lead.find_each(&:save!)
  end
end
