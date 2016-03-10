# Это ошибка, которую сгенерировали специально чтобы она отобразилась на сайте
class SiteError < StandardError
  include HumanizedError
end
