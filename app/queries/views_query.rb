class ViewsQuery
  include Virtus.model

  attribute :landing_id, Integer
  attribute :viewer_uid, String

  def call
    scope = basic_scope

    scope = order scope

    scope
  end

  private

  def basic_scope
    LandingView.where(landing_id: landing_id, viewer_uid: viewer_uid)
  end

  def order(scope)
    scope.order :id
  end
end
