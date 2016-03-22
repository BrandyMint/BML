module MemberRoles
  extend ActiveSupport::Concern

  ROLES = %I(owner master analyst guest).freeze
  DEFAULT_ROLE = :master

  included do
    extend Enumerize

    validates :role, presence: true
    enumerize :role, in: ROLES, default: DEFAULT_ROLE, predicates: true
  end

  def admin?
    owner? || master?
  end

  def invited?
    master? || analyst? || guest?
  end
end
