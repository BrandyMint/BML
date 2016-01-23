require 'capybara/poltergeist'

class LandingScreenShooter
  def make
    driver = Capybara::Poltergeist::Driver.new('app')
    driver.save_screenshot './'
  end
end
