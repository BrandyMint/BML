module LeaderBoard
  # Рейтинговая таблица
  class Table
    include Virtus.model
    attribute :division, String
    attribute :event, String
    attribute :sex, String # male/female
    attribute :records, Array[Record]
  end
end
