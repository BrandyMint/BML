class ExampleVisits
  CITIES = %w(Москва Санкт-Петербурк Чебоксары Казань)

  def self.build
    new.build
  end

  def build
    20.times.map do
      AnalyticVisit.new city: random_city, sessions_count: Random.rand(10), goals_count: Random.rand(2), last_time: Time.now - Random.rand(500).minutes
    end
  end

  private

  def random_city
    CITIES.sample
  end
end
