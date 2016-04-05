class PaymentAccount < ActiveRecord::Base
  belongs_to :account
  validates :card_first_six, :card_last_four, :card_type, :account, presence: true

  scope :by_token, ->(token) { where token: token }
end
