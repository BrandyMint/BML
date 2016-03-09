class AddNumberToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :number, :integer
    Variant.find_each do |v|
      number = 1
      v.leads.ordered.find_each do |l|
        l.update_columns number: number+=1
      end
    end

    change_column :leads, :number, :integer, null: false
  end
end
