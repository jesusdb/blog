# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    message { Faker::Book.title }

    association :user
    association :recipient, factory: :user

    trait :for_article do
      association :notifiable, factory: :article
    end
  end
end
