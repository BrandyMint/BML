module WelcomeHelper
  def welcome_logo
    content_tag :h2, class: 'welcome-header bml-logo' do
      fa_icon :cube, text: AppSettings.title
    end
  end
end
