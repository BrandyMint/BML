class AttachClient
  include Virtus.model(strict: true, nullify_blank: true)

  attribute :lead, Lead

  def call
    lead.update_attribute :client, client
  end

  private

  delegate :landing, to: :lead

  def client
    find_client || create_client
  end

  def find_client
    landing.clients.where('email = ? or phone = ?', lead.email, lead.phone).first
  end

  def create_client
    landing.clients.create!(email: lead.email, phone: lead.phone, name: lead.name, landing: landing)
  end
end
