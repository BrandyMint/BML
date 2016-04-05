module TariffHelper
  def tariff_details(tariff)
    "Абонплата за сайт #{humanized_money_with_symbol tariff.price_per_site} в месяц".html_safe
  end
end
