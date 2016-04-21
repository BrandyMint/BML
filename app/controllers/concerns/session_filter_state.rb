module SessionFilterState
  extend ActiveSupport::Concern

  included do
    before_action :save_session_state
  end

  def session_state
    session[session_state_key]
  end

  def save_session_state
    session[session_state_key] = params[:state] if LeadsFilter::STATES_OPTIONS.include? params[:state]
  end

  def session_state_key
    "#{current_landing.id}:lead_state"
  end
end
