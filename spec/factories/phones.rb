# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    number "MyString"
    user_id 1
    phone_type_id 1
  end
end
