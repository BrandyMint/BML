class ExampleInsights
  INSIGHTS =
    [
      { text: 'Мобильные пользователи имеют низкую конверсию (7% против 15% в десктоп)', type: 'warning' },
      { text: 'Версия N3 имеет более высокую корвесию', type: 'success' },
      { text: '50% пользователей не доскроливают страницу до конца', type: 'warning' },
      { text: 'На версию N4 за сутки не пришел ни один пользователь!', type: 'danger' }
    ].freeze

  def self.build
    INSIGHTS.map do |i|
      AnalyticInsight.new i
    end
  end
end
