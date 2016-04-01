class AccountSmsLogEntity < ActiveRecord::Base
  belongs_to :account, counter_cache: :sms_log_entities_count
end
