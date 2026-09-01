FactoryBot.define do
  factory :character do
    sequence(:name) { |n| "Character #{n}" }
    klass { "Marvel" }
  end
end
