class Collection < ActiveRecord::Base
  belongs_to :landing

  # TODO: belongs_to :account

  has_many :items, dependent: :delete_all, class_name: 'CollectionItem'

  has_many :columns, dependent: :delete_all

  scope :ordered, -> { order :id }
  scope :active, -> { all }

  # Не самый надежный способ
  def next_number
    items.count + 1
  end

  def to_s
    title.presence || default_title
  end

  def last_item_at
    @_last_item_at ||= items.ordered.last.try(:created_at)
  end

  private

  def default_title
    "Таблица #{I18n.l created_at, format: :short}"
  end
end
