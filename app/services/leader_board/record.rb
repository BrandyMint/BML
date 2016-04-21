module LeaderBoard
  # Запись в рейтинговой таблице
  class Record
    include Virtus.model
    attribute :title, String
    attribute :note, String
    attribute :score, Float # TODO: Модель Score # Количество очков
    attribute :rank, Integer # Занятое место (может отсутствовать если еще не посчитали)

    def ==(other)
      as_json == other.as_json
    end
  end
end
