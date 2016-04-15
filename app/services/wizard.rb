# Мастер создания лендинга по наводящим вопросам
module Wizard
  # Список вопросов мастера
  class QuestionList
    attr_reader :wizard_key, :questions

    def initialize(wizard_key)
      @wizard_key = wizard_key
      @questions = wizard['questions'].map { |q| Question.new q }
    end

    def completed?(landing)
      answers(landing).completed.count == questions.count
    end

    def find(key)
      questions.find { |q| q.key == key }
    end

    def next(question)
      next_key = questions.find_index(question) + 1
      questions[next_key]
    end

    def first_empty(landing)
      diff = keys - answers(landing).pluck(:question_key)
      find diff.first
    end

    private

    def answers(landing)
      landing.wizard_answers.where(
        wizard_key: wizard_key,
        question_key: keys
      )
    end

    def keys
      @_keys ||= questions.map(&:key)
    end

    def wizard
      YAML.load_file Rails.root.join("config/wizards/#{wizard_key}.yml")
    end
  end

  # Вопрос мастера
  class Question
    include Virtus.value_object

    values do
      attribute :key, String
      attribute :text, String
      attribute :images_count, Integer
    end
  end
end
