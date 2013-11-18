# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do |f|
    f.title Faker::Lorem.sentence
    f.starts_at Time.now
  end

  factory :future_event, parent: :event do |f|
    f.starts_at 1.day.from_now
  end

  factory :past_event, parent: :event do |f|
    f.starts_at 1.day.ago
  end

  factory :invalid_event, parent: :event do |f|
    f.title nil
  end
end
