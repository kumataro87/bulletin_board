FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "test content number #{n}" }
    created_at { Time.now - 60*10}
    

    trait :yesterday do
      created_at { Time.now - 60*60*24 }
    end

    trait :now do
      created_at { Time.now }
    end
  end

end