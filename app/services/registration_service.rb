class RegistrationService
  include Virtus.model

  attribute :form, RegistrationForm

  def call
    ActiveRecord::Base.transaction do
      create_account create_user
    end
  end

  private

  def create_user
    User.create! form.attributes
  end

  def create_account(user)
    account = Account.create!
    user.memberships.create! account_id: account.id, role: :owner
  end
end
