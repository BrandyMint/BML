class AddRemoteIpToViews < ActiveRecord::Migration
  def change
    add_column :landing_views, :remote_ip, :string
    add_column :landing_views, :user_agent, :string

    add_column :viewers, :remote_ip, :string
    add_column :viewers, :user_agent, :string
  end
end
