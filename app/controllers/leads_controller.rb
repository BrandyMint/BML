class LeadsController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout 'blank'

  def create
    create_lead

    if request.xhr?
      respond_to do |format|
        format.html { render layout: false }
        format.json { render json: { result: 'ok', message: 'Ваша заявка принята!' } }
      end
    else
      render
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
        locals: { backurl: request.referer, message: err.message},
        flash: { error: err.message }
    end
  end

  private

  def render_html_error(err)
    render 'error',
      locals: { message: err.record.errors.to_a.join("<br>") },
      layout: false,
      status: 400
  end

  def render_json_error(err)
    render json: { result: 'error', message: err.record.errors.as_json },
      status: 400
  end

  def create_lead
    LeadCreator.new(params: params, cookies: cookies).call
  end
end
