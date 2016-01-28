module MessageVerifierConcern
  extend ActiveSupport::Concern
  SIGNATURE_PERIOD = 1.day

  included do
    helper_method :account_signature
  end

  def message_verifier
    ActiveSupport::MessageVerifier.new(Secrets.secret_key_base, serializer: YAML)
  end

  def account_signature
    @account_signature ||= message_verifier.generate([current_account.id, SIGNATURE_PERIOD.from_now])
  end
end
