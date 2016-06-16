module LeaderBoard
  # Вычисляет общий рейтинг по всем событиям и добавляет в результаты
  class CommonBuilder < Builder
    COMMON_EVENT = 'Общий рейтинг'.freeze
    POINTS_PER_SCORE = 1 # TODO: Сделать свойством table

    def build
      @results = super
      return results unless results.events.many?

      Results.new(
        divisions: results.divisions,
        events: [COMMON_EVENT] + results.events,
        tables: build_common_tables
      )
    end

    private

    attr_reader :persons_data, :results

    def build_common_tables
      @persons_data = {}

      results.tables.each do |table|
        table.records.each do |record|
          next unless record.score.present?
          add_person_point table[:division], table[:sex], record[:title], record[:note], record.score * POINTS_PER_SCORE
        end
      end

      common_tables = []

      persons_data.each do |division, division_data|
        division_data.each do |sex, sex_data|
          common_tables.push(division: division,
                             event: COMMON_EVENT,
                             sex: sex,
                             records: Ranker.new(records: sex_data.values).rank)
        end
      end

      common_tables + results.tables
    end

    def add_person_point(division, sex, title, note, points)
      data = persons_data[division] ||= {}
      data = data[sex] ||= {}
      key = [title.strip, note.try(:strip)]
            .compact
            .join(':')
            .mb_chars
            .upcase
            .gsub(/\s+/, ' ')
            .to_s
      person = data[key] ||= { title: title, note: note, score: 0 }
      person[:score] += points.to_f
    end
  end
end
