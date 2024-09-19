# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[regular_user] do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    admin { false }
  end

  factory :admin, parent: :user do
    admin { true }
  end
end
