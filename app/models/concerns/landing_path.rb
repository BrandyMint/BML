module LandingPath
  extend ActiveSupport::Concern

  included do
    before_validation :generate_path
    before_validation :clear_path
    before_save :clear_path
    validates :path,
              uniqueness: { scope: :account_id },
              uri_component: { component: :ABS_PATH },
              exclusion: Settings.exclusion_landing_paths
  end

  private

  def clear_path
    self.path = '/' if path.blank?
    return unless path.length > 1

    self.path = path.slice(0, path.length - 1) if path.end_with? '/'
  end

  def generate_path
    self.path ||= '/' + SecureRandom.hex(4)
  end
end
