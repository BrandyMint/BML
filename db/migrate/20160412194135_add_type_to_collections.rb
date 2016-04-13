class AddTypeToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :type, :string, null: false, default: 'LeadsCollection'

    # Рейтинг для RedShell
    Collection.where(id: 16).update_all type: 'RecordsCollection'
  end
end
