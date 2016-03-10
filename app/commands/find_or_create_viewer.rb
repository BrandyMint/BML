class FindOrCreateViewer
  include Virtus.model

  attribute :uid

  def call
    find_viewer || create_viewer
  end

  private

  def find_viewer
    viewer = Viewer.find_by_uid uid
    viewer.try :touch
    viewer
  end

  def create_viewer
    Viewer.create! uid: uid
  end
end
