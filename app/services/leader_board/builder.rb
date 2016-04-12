module LeaderBoard
  # Строит данные для отображения в LeaderBoard
  # на основе коллекции
  class Builder
    include Virtus.model strict: true

    attribute :collection, Collection

    def build
      @divisions = []
      @events    = []
      build_results

      {
        divisions: @divisions.uniq.sort,
        events: @events.uniq.compact.sort,
        tables: Ranker.new(results: @results.values).rank!
      }
    end

    private

    EVENT_COLUMN      = :event
    SCORE_COLUMN      = :score
    DIVISION_COLUMN   = :division
    MALE_COLUMN       = :is_male
    NOTE_COLUMN       = :city
    TITLE_COLUMN      = :name

    DEFAULT_EVENT     = 'DefaultEvent'.freeze
    DEFAULT_division = 'DefaultDivision'.freeze

    def add_division(division)
      @divisions.push(division)
    end

    def add_event(event)
      @events.push(event)
    end

    def build_results
      @results = {}
      leads.find_each do |lead|
        division = lead.data[DIVISION_COLUMN] || DEFAULT_division
        add_division division

        event = lead.data[EVENT_COLUMN] || DEFAULT_EVENT
        add_event event

        is_male = lead.data[MALE_COLUMN] || false

        note = lead.data[NOTE_COLUMN]
        title = lead.data[TITLE_COLUMN]
        score = lead.data[SCORE_COLUMN].to_i
        score = nil if score == 0;

        ranks_table = find_ranks_table(division, event, is_male)
        add_rank ranks_table[:records], title, score, note
      end
    end

    def result_key(*categories)
      categories.join(':')
    end

    def find_ranks_table(division, event, is_male)
      get_ranks_table(division, event, is_male) || create_ranks_table(division, event, is_male)
    end

    def get_ranks_table(division, event, is_male)
      key = result_key division, event, is_male
      @results[key]
    end

    def create_ranks_table(division, event, is_male)
      key = result_key division, event, is_male

      ranks_table = {
        division: division,
        event: event,
        is_male: is_male,
        records: []
      }
      @results[key] = ranks_table
    end

    def add_rank(ranks, title, score, note)
      ranks << { title: title, note: note, score: score }
    end

    def leads
      collection.leads.accepted
    end
  end
end
