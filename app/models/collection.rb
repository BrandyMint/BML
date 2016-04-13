class Collection < ActiveRecord::Base
  belongs_to :landing

  # TODO: belongs_to :account

  has_many :leads, dependent: :delete_all

  has_many :columns, dependent: :delete_all

  scope :ordered, -> { order :id }
  scope :active, -> { all }

  def to_s
    title.presence || default_title
  end

  def last_lead_at
    @_last_lead_at ||= leads.ordered.last.try(:created_at)
  end

  private

  def default_title
    "Таблица #{I18n.l created_at, format: :short}"
  end
end
