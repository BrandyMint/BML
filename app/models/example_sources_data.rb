class ExampleSourcesData
  SEGMENTS = {
    yandex_direct: ['Компания 1', 'Компания 4'],
    google_adwords: ['Компания 3', 'Компания 4'],
    search: ['как разбить стекло', 'откуда берутся мухи'],
    social: ['Группа vkontakte'],
    organic: ['Москва', 'Регионы'],
    mails: ['Возвращайся скорее', 'Скидки до 15%']
  }

  def self.build
    new.build
  end

  def build
    AnalyticSource.sources.map do |source|
      source.segments = build_segments source.key
      source.percent = random_percent
      source
    end
  end

  private

  def build_segments(source)
    segments = SEGMENTS[source.to_sym] or fail "No segments for #{source}"
    segments.map do |segment|
      AnalyticSource::Segment.new title: segment, conversion: random_conversion, users: random_users, percent: random_conversion
    end
  end

  def random_users
    Random.rand(100).to_f/10
  end

  def random_percent
    Random.rand(1000).to_f/10
  end

  def random_conversion
    Random.rand(100).to_f/10
  end
end
