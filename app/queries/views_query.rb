class ViewsQuery
  include Virtus.model

  attribute :landing_id, Integer
  attribute :viewer_uid, String

  def call
    scope = basic_scope

    scope = scope.where(viewer_uid: viewer_uid) if viewer_uid.present?

    scope = order scope

    scope
  end

  private

  def basic_scope
    LandingView.where(landing_id: landing_id)
  end

  def order(scope)
    scope.order('id desc')
  end
end
