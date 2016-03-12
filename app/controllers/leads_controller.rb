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
      # TODO кидать назад не совсем удачно.
      # 1. На предыдущей странице не узнают какие были ошибки, не смогу выделить.
      # Может быть надо передавать список ошибочных полей и текст ошибки в параметрах.
      #

      render 'error',
        locals: { backurl: request.referer, message: err.message },
        flash: { error: err.message }
    end
  end

  private

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

  def create_lead
    @_lead ||= CreateLead.new(
      params: params,
      cookies: cookies,
      viewer_uid: current_viewer_uid,
    ).call
  end

  def lead
    @_lead
  end
end
