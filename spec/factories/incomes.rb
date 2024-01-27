# spec/factories/incomes.rb
FactoryBot.define do
  factory :income do
    amount { rand(1..1000) }
    association :user
  end
end
