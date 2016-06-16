class Account::CloudPaymentsController < Account::BaseController
  layout 'account'
  skip_before_action :verify_authenticity_token, only: [:post3ds]

  def new
    render :new, locals: { form: form }
  end

  def create
    charge_balance one_time_payment
    success_redirect

  rescue Payments::Secure3dRedirect => ex
    render :form3ds, locals: form_3ds_keys(ex.resp), layout: false

  rescue Payments::InvalidForm
    send :new

  rescue CloudPaymentsError, ActiveRecord::RecordInvalid => err
    flash.now[:error] = err.message
    send :new
  end

  def post3ds
    resp = handle_3ds
    unset_save_card_flag
    charge_balance resp
    success_redirect

  rescue CloudPaymentsError, ActiveRecord::RecordInvalid => err
    flash.now[:error] = err.message
    send :new
  end

  private

  def form
    @_form ||= CloudPaymentsForm.new recurrent: true, **permitted_params.symbolize_keys
  end

  def one_time_payment
    make_response CloudPayments::OneTimePayment.new(
      session: session,
      account: current_account,
      form: form,
      ip: request.remote_ip
    ).call
  end

  def handle_3ds
    make_response CloudPayments::Post3ds.new(
      md: params['MD'],
      pa_res: params['PaRes']
    ).call
  end

  def form_3ds_keys(response)
    @_form_3ds_keys ||= CloudPayments::Form3dsKeys.new(response.to_hash).as_json
  end

  def make_response(response)
    Payments::Response.build_from_gateway_response response, Payments::CLOUDPAYMENTS_GATEWAY_KEY, save_card?
  end

  def charge_balance(response)
    Payments::ChargeBalanceFromTransaction.new(
      account: current_account,
      transaction: response.transaction,
      card: response.card
    ).call
  end

  def save_card?
    form.recurrent? || session[Payments::CLOUDPAYMENTS_SAVE_CARD_KEY]
  end

  def unset_save_card_flag
    session.delete Payments::CLOUDPAYMENTS_SAVE_CARD_KEY
  end

  def success_redirect
    redirect_to account_billing_path, flash: { success: I18n.t('flashes.balance.charged') }
  end

  def permitted_params
    params.require(:cloud_payments_form).permit(:name, :recurrent, :amount_cents, :amount_currency, :cryptogram_packet)
  rescue
    {}
  end
end
