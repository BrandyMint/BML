class Account::PaymentsController < Account::BaseController
  layout 'account'

  def new
    render locals: { balance_payment_form: balance_payment_form }
  end

  def create
    charge_balance
    redirect_to account_billing_path, flash: { success: I18n.t('flashes.balance.charged') }

  rescue CloudPayments::OneTimeChargeBalance::InvalidForm
    render :new, locals: { balance_payment_form: balance_payment_form }

  rescue CloudPaymentsError, ActiveRecord::RecordInvalid => err
    flash.now[:error] = err.message
    render :new, locals: { balance_payment_form: balance_payment_form }
  end

  private

  def balance_payment_form
    @_balance_payment_form ||= BalancePaymentForm.new permitted_params
  end

  def charge_balance
    CloudPayments::OneTimeChargeBalance.new(
      account: current_account,
      form: balance_payment_form,
      ip: request.remote_ip
    ).call
  end

  def permitted_params
    params.require(:balance_payment_form).permit(:name, :email, :recurrent, :amount, :cryptogram_packet)
  rescue
    {}
  end
end
