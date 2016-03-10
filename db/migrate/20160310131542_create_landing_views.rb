class CreateLandingViews < ActiveRecord::Migration
  def change
    create_table :landing_views do |t|
      t.string :viewer_uid, null: false, index: true
      t.belongs_to :account, index: true, foreign_key: true
      t.belongs_to :landing, index: true, foreign_key: true
      t.belongs_to :variant, index: true, foreign_key: true
      t.string :url, null: false
      t.string :utm_source
      t.string :utm_campaign
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :referer

      t.timestamps null: false
    end

    add_foreign_key :landing_views, :viewers, column: :viewer_uid, primary_key: :uid
  end
end
