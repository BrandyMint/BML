class ChangeUrlToLandingViews < ActiveRecord::Migration
  def change
    change_column :landing_views, :url, :string, limit: 4096
    change_column :landing_views, :referer, :string, limit: 4096

    Lead::UTM_FIELDS.each do |f|
      change_column :landing_views, f, :string, limit: 4096
    end
  end
end
