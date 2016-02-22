class RegistrationService
  include Virtus.model

  attribute :form, RegistrationForm

  def call
    account = nil
    ActiveRecord::Base.transaction do
      account = create_account create_user
    end

    fail 'Error creating account' unless account.present?
    return account
  end

  private

  def create_user
    User.create! form.attributes
  end

  def create_account(user)
    account = Account.create!
    user.memberships.create! account_id: account.id, role: :owner

    return account
  end
end
