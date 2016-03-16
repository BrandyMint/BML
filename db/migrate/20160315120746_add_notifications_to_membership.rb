class AddNotificationsToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :email_notification, :boolean, default: true, null: false
    add_column :memberships, :sms_notification, :boolean, default: true, null: false
  end
end
