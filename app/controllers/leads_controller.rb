class LeadsController < ApplicationController
  include CurrentViewer

  skip_before_action :verify_authenticity_token
  layout 'lead'

  def create
    create_lead

    if request.xhr?
      respond_to do |format|
        format.html { render locals: { lead: lead }, layout: false }
        format.json { render json: { result: 'ok', message: 'Ваша заявка принята!', lead: lead.as_json } }
      end
    else
      render locals: { lead: lead }
    end

  rescue ActiveRecord::RecordInvalid => err
    if request.xhr?
      respond_to do |format|
        format.html { render_html_error err }
        format.json { render_json_error err }
      end
    else
      # TODO: кидать назад не совсем удачно.
      # 1. На предыдущей странице не узнают какие были ошибки, не смогу выделить.
      # Может быть надо передавать список ошибочных полей и текст ошибки в параметрах.
      #

      render 'error',
             locals: { backurl: request.referer, message: err.message },
             flash: { error: err.message }
    end
  end

  private

  DATA_EXCEPTIONS = [:variant_uuid, :tracking, :controller, :action, :utf8, :authenticity_token, :commit].freeze

  def current_variant
    @_current_variant ||= Variant.where(uuid: variant_uuid).first! || raise("No such variant #{variant_uuid}")
  end

  def current_landing
    current_variant.landing
  end

  def variant_uuid
    params[:variant_uuid]
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
      viewer_uid: current_viewer_uid
    ).call
  end

  def lead
    @_lead
  end
end
