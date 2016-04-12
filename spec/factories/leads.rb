FactoryGirl.define do
  factory :lead do
    landing
    collection { create :collection, landing: landing }
    variant { create :variant, landing: landing }
    data { { name: 'asdf' } }
  end

  trait :accepted do
    state LeadStates::STATE_ACCEPTED
  end

  trait :with_utm_fields do
    last_utm_source 'utm'
    last_utm_campaign 'utm'
    last_utm_medium 'utm'
    last_utm_term 'utm'
    last_utm_content 'utm'
    last_referer 'utm'
  end
end
