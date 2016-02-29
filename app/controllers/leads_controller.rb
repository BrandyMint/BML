class LeadsController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout 'blank'

  DATA_EXCEPTIONS = [:landing_version_uuid, :controller, :action, :utf8, :authenticity_token, :commit]

  def create
    create_lead!

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

  def create_lead!
    # fail ActiveRecord::RecordInvalid.new(self) unless valid?

    collection
      .items
      .create! lead_attributes

    # rescue ActiveRecord::RecordNotFound => err
    # errors.add :base, err.message
    # raise ActiveRecord::RecordInvalid.new(self)
  end

  def lead_attributes
    {
      data: data, landing_version: landing_version
    }
  end

  def collection
    find_collection || landing_version.landing.default_collection
  end

  def find_collection
    # TODO
  end

  def landing_version
    @_landing_version ||= LandingVersion.where(uuid: params[:landing_version_uuid]).first!
  end

  def data
    Hash[params.except(*DATA_EXCEPTIONS).map { |k, v| [k.downcase, v] }]
  end
end
