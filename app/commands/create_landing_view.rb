# Сохраняет просмотр лендинга
class CreateLandingView
  include Virtus.model

  attribute :viewer, Viewer
  attribute :variant, Variant
  attribute :url
  attribute :utms
  attribute :remote_ip
  attribute :user_agent

  def call
    LandingView.create! view_attributes
  end

  private

  def view_attributes
    utms.merge(
      user_agent: user_agent,
      remote_ip:  remote_ip,
      viewer_uid: viewer.uid,
      account_id: variant.account_id,
      landing_id: variant.landing_id,
      variant_id: variant.id,
      url: url
    )
  end
end
