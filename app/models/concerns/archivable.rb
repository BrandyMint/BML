module Archivable
  extend ActiveSupport::Concern

  included do
    scope :archived, -> { where.not deleted_at: nil }
    scope :alive,    -> { where deleted_at: nil }
  end

  def archive
    self.deleted_at ||= Time.zone.now
  end

  def archive!
    archive
    update! deleted_at: deleted_at
  end

  def restore
    self.deleted_at = nil
  end

  def restore!
    restore
    update! deleted_at: deleted_at
  end

  def archived?
    deleted_at.present?
  end

  def alive?
    deleted_at.nil?
  end

  def alive_presence
    alive? ? self : nil
  end
end
