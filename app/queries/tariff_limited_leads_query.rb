# Запрос заявок согласно ограничениям тарифа
class TariffLimitedLeadsQuery < LeadsQuery
  def limit(s)
    s = s.limit filter.account.features.leads_limit
    s
  end
end
