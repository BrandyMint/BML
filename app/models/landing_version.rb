class LandingVersion < ActiveRecord::Base
  belongs_to :landing, counter_cache: :versions_count
  has_many :sections

  scope :ordered, -> { order :id }

  def to_s
    title.presence || I18n.l(created_at, format: :short)
  end
end
