# query-object для получения посетителей сайта
class ViewersQuery
  include Virtus.model

  attribute :landing_id, Integer

  def call
    scope = basic_scope

    scope = order scope

    scope
  end

  private

  def basic_scope
    Viewer.where(landing_id: landing_id)
  end

  def order(scope)
    scope.order('updated_at desc')
  end
end
