module AccountControllerSupport
  extend ActiveSupport::Concern

  included do
    def self.helper_method(_args)
    end

    include CurrentAccount

    render_views

    let!(:account)    { create :account }
    let!(:user)       { create :user }
    let!(:membership) { create :membership, user: user, account: account }

    before do
      allow(controller).to receive(:current_account).and_return account
      allow(controller).to receive(:current_user).and_return user
      allow(controller).to receive(:current_member).and_return membership
      @request.env['HTTP_REFERER'] = 'http://new.example.com:3000/back'

      current_account = account # rubocop:disable Lint/UselessAssignment
    end
  end
end
