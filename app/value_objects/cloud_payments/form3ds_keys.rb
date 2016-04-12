module CloudPayments
  # Ключи из ответа шлюза для 3D Secure формы
  class Form3dsKeys < Grape::Entity
    expose :acs_url, as: :action
    expose :pa_req
    expose :transaction_id, as: :md
    expose :term_url do |_resp, _o|
      Rails.application.routes.url_helpers.post3ds_account_cloud_payments_url
    end
  end
end
