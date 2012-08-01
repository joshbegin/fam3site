# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:first_name)  { |n| "First#{n}" }
    sequence(:middle_name) { |n| "Middle#{n}"}
    sequence(:last_name) { |n| "Last#{n}"}
    gender_id 1
    birthdate "2001-10-24"
    sequence(:username) { |n| "User#{n}"}
    password "foobar"
    password_confirmation "foobar"
  end
end
