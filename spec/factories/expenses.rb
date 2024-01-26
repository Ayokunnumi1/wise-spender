# spec/factories/expenses.rb
FactoryBot.define do
  factory :expense do
    sequence(:name) { |n| "Expense #{n}" }
    amount { rand(1..1000) }
    association :author, factory: :user
    association :category
  end
end