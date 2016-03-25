class AddTariffIdToAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :tariff, index: true, foreign_key: true
  end
end
