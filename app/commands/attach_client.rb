# Находит или создает клиента, создавшего заявку, и привязывает его к этой заявке
class AttachClient
  include Virtus.model(strict: true, nullify_blank: true)
  UNKNOWN_NAME = 'Неизвестное имя'.freeze

  attribute :lead, Lead

  def call
    raise 'Must be a Lead' unless lead.is_a? Lead
    return unless lead.email.present? || lead.phone.present?

    lead.update_attribute :client, client
    client
  end

  private

  delegate :landing, to: :lead

  def client
    find_client || create_client
  end

  def find_client
    landing.default_clients_collection.clients.by_email_or_phone(lead.email, lead.phone).first
  end

  def create_client
    landing.default_clients_collection.clients.create! data: client_data, landing: landing
  end

  def client_data
    lead.data.slice(*CollectionItem::CLIENT_FIELDS)
  end
end
