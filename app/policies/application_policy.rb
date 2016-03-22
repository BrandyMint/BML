class ApplicationPolicy
  attr_reader :member, :resource

  def initialize(member, resource)
    @member = member
    @resource = resource
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    member.admin?
  end

  def new?
    create?
  end

  def update?
    member.admin?
  end

  def edit?
    update?
  end

  def destroy?
    member.admin? && resource.present? && resource.persisted?
  end
end
