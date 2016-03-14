module BugsnagSupport
  extend ActiveSupport::Concern

  included do
    before_bugsnag_notify :add_info_to_bugsnag
  end

  private

  def add_info_to_bugsnag(notif)
    return unless current_user.present?
    notif.user = {
      email: current_user.email,
      name: current_user.name,
      id: current_user.id
    }
  end
end
