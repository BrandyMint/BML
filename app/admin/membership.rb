ActiveAdmin.register Membership do
  permit_params Membership.attribute_names

  index do
    selectable_column
    column :id
    column :account
    column :member do |member|
      member.user.name
    end
    column :role
    actions
  end
end
