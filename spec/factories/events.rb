# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do |f|
    f.title Faker::Lorem.sentence
  end

  factory :invalid_event, parent: :event do |f|
    f.title nil
  end
end
