module LeaderBoard
  # Возвращаемые результаты
  class Results
    include Virtus.model

    attribute :divisions, Array[String]
    attribute :events, Array[String]
    attribute :tables, Array[Table]
  end
end
