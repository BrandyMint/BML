module LandingPath
  extend ActiveSupport::Concern

  included do
    before_validation :clear_path
    before_validation :generate_path
    before_save :clear_path
    validates :path,
              uniqueness: true,
              uri_component: { component: :ABS_PATH },
              exclusion: Settings.exclusion_landing_paths
  end

  private

  def clear_path
    if self.path.blank?
      self.path = '/'
    end
    if self.path.length > 1
      self.path = self.path.slice(0, self.path.length-1) if self.path.end_with? '/'
    end
  end

  def generate_path
    self.path ||= '/' + SecureRandom.hex(4)
  end
end
