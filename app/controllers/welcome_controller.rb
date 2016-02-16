class WelcomeController < ApplicationController
  def index
    redirect_to 'http://molodost.bz' if request.domain.ends_with? 'bmland.ru'
  end
end
