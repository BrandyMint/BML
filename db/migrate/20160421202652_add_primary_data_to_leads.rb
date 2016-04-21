class AddPrimaryDataToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :primary_data, :hstore, null: false, default: {}
    execute 'update leads set primary_data = data';
  end
end
