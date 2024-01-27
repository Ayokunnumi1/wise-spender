# spec/factories/categories.rb
FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    icon { "icon.png" }
    association :user
  end
end