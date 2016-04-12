class LeadsController < ApplicationController
  include CurrentViewer

  skip_before_action :verify_authenticity_token
  layout 'lead'

  rescue_from CreateLead::Error, with: :rescue_lead_error

  def create
    send_notifications create_lead

    if request.xhr?
      respond_to do |format|
        format.html { render locals: { lead: lead }, layout: false }
        format.json { render json: { result: 'ok', message: 'Ваша заявка принята!', lead: lead.as_json } }
      end
    else
      render locals: { lead: lead }
    end

  rescue ActiveRecord::RecordInvalid => err
    # TODO: Раз это ошибка формы, ее надо как-то более
    # информативно возвращать
    rescue_lead_error err
  end

  private

  DATA_EXCEPTIONS = [:subdomain, :cookie, :viewer_uid, :variant_uuid, :tracking, :controller, :action, :utf8, :authenticity_token, :collection_uuid, :commit].freeze
  EXCLUDE_ERRORS = [CreateLead::UnknownError].freeze

  def rescue_lead_error(error)
    Bugsnag.notify error unless EXCLUDE_ERRORS.include? error.class

    if request.xhr?
      render_xrh_lead_error error
    else
      # TODO: кидать назад не совсем удачно.
      # 1. На предыдущей странице не узнают какие были ошибки, не смогу выделить.
      # Может быть надо передавать список ошибочных полей и текст ошибки в параметрах.
      #

      render 'error',
             locals: { backurl: backurl, error: error },
             flash: { error: error.message }
    end
  end

  def backurl
    a = Addressable::URI.parse current_landing.url
    a.fragment = Landing::FORM_FRAGMENT
    a.to_s
  end

  def current_account
    current_landing.account
  end

  def current_variant
    @_current_variant ||= Variant.find_by_uuid(variant_uuid) || raise("No such variant #{variant_uuid}")
  end

  def current_landing
    current_variant.landing
  end

  def variant_uuid
    params[:variant_uuid]
  end

  def render_xhr_lead_error(err)
    respond_to do |format|
      format.html { render_html_error err }
      format.json { render_json_error err }
    end
  end

  def render_html_error(err)
    render 'error',
           locals: { message: err.record.errors.to_a.join('<br>') },
           layout: false,
           status: 400
  end

  def render_json_error(err)
    render json: { result: 'error', message: err.record.errors.as_json },
           status: 400
  end

  def lead_params
    Hash[params.except(*DATA_EXCEPTIONS).map { |k, v| [k.downcase, v] }]
  end

  def create_lead
    @_lead ||= CreateLead.new(
      data:       lead_params,
      variant:    current_variant,
      tracking:   params[:tracking] || '',
      cookies:    cookies,
      viewer_uid: current_viewer_uid,
      collection_uuid: params[:collection_uuid] || ''
    ).call
  end

  def send_notifications(lead)
    LeadCreatedNotifier.new(lead: lead, account: current_account).call
  rescue => e
    raise e unless Rails.env.production?
    Bugsnag.notify e
  end

  def lead
    @_lead
  end
end
