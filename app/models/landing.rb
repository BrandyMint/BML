class Landing < ActiveRecord::Base
  belongs_to :account, counter_cache: true

  has_many :sections
  has_many :collections

  validates :title, presence: true

  def to_s
    title
  end
end
