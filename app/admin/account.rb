include MoneyHelper

ActiveAdmin.register Account do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    column :id
    column :created_at
    column :updated_at
    column :ident
    column :name
    column :url
    column :balance do |resource|
      humanized_money_with_symbol(resource.billing_account.amount)
    end
    actions do |resource|
      link_to 'Пополнить баланс', charge_balance_admin_account_url(resource), class: 'member_link'
    end
  end

  member_action :charge_balance, method: [:get, :post] do
    if request.post?
      begin
        amount = params[:account][:balance_amount].to_money params[:account][:balance_currency]

        Billing::GiftChargeBalance.new(
          account: resource,
          amount: amount,
          description: params[:account][:description],
          user: current_active_admin_user
        ).call

        redirect_to admin_accounts_url, flash: { success: I18n.t('flashes.activeadmin.balance_charged') }
      rescue => err
        redirect_to :back, flash: { error: err.message }
      end
    else
      render :charge_balance
    end
  end
end
