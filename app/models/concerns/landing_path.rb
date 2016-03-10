module LandingPath
  extend ActiveSupport::Concern

  included do
    before_validation :generate_path
    validates :path,
      uniqueness: true,
      uri_component: { component: :ABS_PATH },
      exclusion: Settings.exclusion_landing_paths
  end

  private

  def generate_path
    self.path ||= '/' + SecureRandom.hex(4)
  end
end
