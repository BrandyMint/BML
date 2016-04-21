FactoryGirl.define do
  factory :tariff_month do
    account
    tariff
    month Time.zone.today
  end
end
