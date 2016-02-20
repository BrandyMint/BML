class CollectionItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    form.save

    if request.xhr?
      respond_to do |format|
        format.html { render layout: false }
        format.json { render json: { result: 'ok', message: 'Ваша заявка принята!' } }
      end
    else
      render layout: 'system'
    end

  rescue ActiveRecord::RecordInvalid => err
    if request.xhr?
      respond_to do |format|
        format.html { render_html_error err }
        format.json { render_json_error err }
      end
    else
      redirect_to :back, flash: { error: err.message }
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

  def form
    @_form ||= RequestForm.new params: params
  end
end
