module LeadStates
  extend ActiveSupport::Concern

  STATE_NEW = 'new'.freeze
  STATE_ACCEPTED = 'accepted'.freeze
  STATE_DECLINED = 'declined'.freeze

  included do
    scope :accepted, -> { with_state STATE_ACCEPTED }
    enumerize :state,
              in: [STATE_NEW, STATE_ACCEPTED, STATE_DECLINED],
              default: STATE_NEW,
              predicates: { prefix: true },
              scope: true
  end

  def accept
    update! state: STATE_ACCEPTED
  end

  def decline
    update! state: STATE_DECLINED
  end
end
