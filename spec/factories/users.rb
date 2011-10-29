# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "MyString"
    middle_name "MyString"
    last_name "MyString"
    gender_id 1
    birthdate "2011-10-24"
    username "MyString"
    password "foobar"
    password_confirmation "foobar"
  end
end
