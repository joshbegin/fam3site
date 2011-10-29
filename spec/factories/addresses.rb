# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    line_1 "MyString"
    line_2 "MyString"
    line_3 "MyString"
    city "MyString"
    state_id 1
    zip "MyString"
    user_id 1
    address_type_id 1
  end
end
