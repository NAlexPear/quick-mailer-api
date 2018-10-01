FactoryBot.define do
  factory :message do
    name { Faker::BojackHorseman.character }
    email { Faker::Internet.email }
    subject { Faker::Company.bs }
  end
end
