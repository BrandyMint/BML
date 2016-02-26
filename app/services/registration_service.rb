class RegistrationService
  include Virtus.model

  UserDuplicate = Class.new StandardError

  attribute :form, RegistrationForm

  def call
    user = nil
    ActiveRecord::Base.transaction do
      user = create_user
      create_account user
    end

    fail 'Error creating user' unless user.present?
    return user
  end

  private

  def create_user
    fail UserDuplicate if find_user
    User.create! form.attributes
  end

  def find_user
    User.find_by(email: form.email) || User.find_by(phone: form.phone)
  end

  def create_account(user)
    account = Account.create!
    user.memberships.create! account_id: account.id, role: :owner
  end
end
