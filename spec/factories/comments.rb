# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { Faker::Books::Lovecraft.sentence }

    association :user
    association :article
  end
end
