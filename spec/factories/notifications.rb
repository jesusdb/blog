FactoryBot.define do
  factory :notification do
    message { "MyString" }
    user { nil }
    recipient_id { 1 }
    notifiable_type { "MyString" }
    notifiable_id { 1 }
  end
end
