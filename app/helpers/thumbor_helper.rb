module ThumborHelper
  SERVER_URL = 'http://thumbor4.tasty0.ru/unsafe/'
  LANDING_PREVIEW_SIZE = '320x240'

  def thumbor_image_url(image_url, size='320x240')
    SERVER_URL + "#{size}/" + image_url
  end
end
