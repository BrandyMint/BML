class AnalyticVisit
  include Virtus.model

  attribute :name, String
  attribute :city, String
  attribute :last_time, Time
  attribute :sessions_count, Integer
  attribute :goals_count, Integer
end
