module HtmlOnly
  extend ActiveSupport::Concern
  # Защищаемся от ошибок с отутсвием шаблонов для запросов типа:
  # curl -H 'Accept: image/gif, image/x-xbitmap, image/jpeg,image/pjpeg, application/x-shockwave-flash,application/vnd.ms-excel,application/vnd.ms-powerpoint,application/msword'

  included do
    before_action :filter_html

    rescue_from UnknownFormat do |_exception|
      render inline: 'Supports html only', status: 415
    end
  end

  private

  def filter_html
    fail UnknownFormat unless request.format.html_types.include? :html

    # request.format.html?
    # Не срадабывает с Accept: */*
  end
end
