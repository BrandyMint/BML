module ThumborHelper
  SERVER_URL             = 'http://thumbor4.tasty0.ru/unsafe/'
  LANDING_PREVIEW_WIDTH  = 320
  LANDING_PREVIEW_HEIGHT = 240
  LANDING_PREVIEW_SIZE   = "#{LANDING_PREVIEW_WIDTH}x#{LANDING_PREVIEW_HEIGHT}"

  def thumbor_image_url(image_url, size='320x240')
    SERVER_URL + "#{size}/" + image_url
  end
end
