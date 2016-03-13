class AddLandingIdToViewers < ActiveRecord::Migration
  def up
    remove_column :landing_views, :viewer_uid
    add_column :landing_views, :viewer_uid, :string

    remove_column :leads, :viewer_uid
    add_column :leads, :viewer_uid, :string
    drop_table :viewers

    create_table :viewers do |t|
      t.string :uid, null: false
      t.references :landing, null: false

      t.timestamps null: false
    end
    add_index "viewers", [:landing_id, :uid], unique: true
  end

  def down
    fail 'not supported'
  end
end
