class ChangeDefaultRoleInMember < ActiveRecord::Migration
  def change
    change_column_default :memberships, :role, nil
    execute "UPDATE memberships SET role = 'master' WHERE role = 'manager'"
  end
end
