# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    address "MyString"
    email_type_id 1
    user_id 1
  end
end
