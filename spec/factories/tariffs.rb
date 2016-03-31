FactoryGirl.define do
  factory :tariff do
    title 'MyString'
    description 'MyString'
    slug Tariff::BASE_SLUG
    price_per_month_cents 100
    price_per_month_currency 'MyString'
    price_per_site_cents 100
    price_per_site_currency 'MyString'
    price_per_lead_cents 100
    price_per_lead_currency 'MyString'
    free_days_count 1
    free_leads_count 1
  end
end
