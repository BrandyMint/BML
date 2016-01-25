class APIPing < Grape::API
  content_type :txt, 'text/plain'
  format :txt
  default_format :txt
  resource :ping do
    get do
      'ok ' + Time.now.to_s
    end
  end
end
