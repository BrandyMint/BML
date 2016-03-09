class AddUtmFieldsToLeads < ActiveRecord::Migration
  def change
    change_table :leads do |t|
      Lead::UTM_FIELDS.each do |f|
        t.string f
      end
    end
  end
end
