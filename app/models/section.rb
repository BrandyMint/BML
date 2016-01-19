class Section < ActiveRecord::Base
  belongs_to :landing, counter_cache: true

  before_create :generate_uuid

  private

  def generate_uuid
    self.uuid ||= UUID.new.generate
  end
end
