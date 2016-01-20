class CreateLandingVersions < ActiveRecord::Migration
  def change
    create_table :landing_versions do |t|
      t.references :landing, index: true, foreign_key: true, null: false
      t.string :title

      t.timestamps null: false
    end

    Section.delete_all
    Landing.delete_all

    add_column :landings, :versions_count, :integer, null: false, default: 0
    remove_column :landings, :version

    add_column :sections, :landing_version_id, :integer, foreign_key: true, index: true, null: false
    remove_column :sections, :landing_id
  end
end
