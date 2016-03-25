class AddUniquenessToTariffes < ActiveRecord::Migration
  def change
    Account.update_all tariff_id: nil
    Tariff.delete_all
    add_index :tariffs, [:title], unique: true
    add_index :tariffs, [:slug], unique: true
    SeedTariffes.new.perform
  end
end
