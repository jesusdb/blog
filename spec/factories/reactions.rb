FactoryBot.define do
  factory :reaction do
    status { 1 }
    user { nil }
    reactionable_type { "MyString" }
    reactionable_id { 1 }
  end
end
