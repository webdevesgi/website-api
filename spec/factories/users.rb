# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.password { Faker::Lorem.characters(10) }
  end

  factory :user_with_clear_password, parent: :user do |f|
    str = Faker::Lorem.characters(10)
    f.name { str }
    f.password { str }
  end

  factory :invalid_user_name, parent: :user do |f|
    f.name nil
  end

  factory :invalid_user_email_present, parent: :user do |f|
    f.email nil
  end

  factory :invalid_user_email_syntax, parent: :user do |f|
    f.email Faker::Lorem.characters(5)
  end

  factory :invalid_user_password, parent: :user do |f|
    f.password nil
  end

  factory :invalid_user_password_length, parent: :user do |f|
    f.password Faker::Lorem.characters(3)
  end
end
