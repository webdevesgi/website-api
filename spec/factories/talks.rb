# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do |f|
    f.title { Faker::Lorem.sentence }
    f.description { Faker::Lorem.sentence }
  end

  factory :invalid_talk, parent: :talk do |f|
    f.title nil
  end
end
