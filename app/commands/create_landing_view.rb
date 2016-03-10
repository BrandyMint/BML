class CreateLandingView
  include Virtus.model

  attribute :viewer, Viewer
  attribute :variant, Variant
  attribute :url
  attribute :utms

  def call
    LandingView.create! view_attributes
  end

  private

  def view_attributes
    utms.merge(
      {
        viewer_uid: viewer.uid,
        account_id: variant.account.id,
        landing_id: variant.landing.id,
        variant_id: variant.id,
        url: url
      }
    )
  end
end
