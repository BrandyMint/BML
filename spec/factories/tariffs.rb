FactoryGirl.define do
  sequence :tariff_title do |n|
    "title#{n}"
  end

  sequence :tariff_slug do |n|
    "slug#{n}"
  end

  factory :tariff do
    title { generate :tariff_title }
    description 'MyString'
    slug { generate :tariff_slug }
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
