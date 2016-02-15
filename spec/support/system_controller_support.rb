module SystemControllerSupport
  extend ActiveSupport::Concern
  included do
    render_views

    let!(:user) { nil }

    before do
      allow(controller).to receive(:current_user).and_return user
      @request.env['HTTP_REFERER'] = 'http://new.example.com:3000/back'
      # @request.host = Settings.app.default_url_options.host
    end
  end
end
