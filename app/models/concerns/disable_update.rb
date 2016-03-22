module DisableUpdate
  extend ActiveSupport::Concern

  included do
    before_save :disable_update, on: :update
  end

  private

  def disable_update
    raise 'You can not update invite, only create' if persisted?
  end
end
