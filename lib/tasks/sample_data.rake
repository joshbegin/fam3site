# bundle exec rake db:reset # clear out current values in dev
# bundle exec rake db:populate # run this in dev
# bundle exec rake db:test:prepare # clear everything and run this in test

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_addresses
    make_phones
    make_emails
  end
end

def make_users
  admin = User.create!( first_name:             "Joshua",
                        middle_name:            "Michael",
                        last_name:              "Begin",
                        gender_id:              "1",
                        birthdate:              "1979-06-03",
                        username:               "jbegin",
                        password:               "foobar",
                        password_confirmation:  "foobar")
  puts "Josh user created"
  admin.toggle!(:admin)
  puts "First user turned into Admin"
  99.times do |n|
    firstname  = Faker::Name.first_name
    lastname  = Faker::Name.last_name
    gender = ["1","2"].sample
    birthdate = "#{(1900..2012).to_a.sample}-#{('01'..'12').to_a.sample}-#{('01'..'28').to_a.sample}"
    username = "#{firstname.downcase}_#{lastname.downcase}"
    password  = "password"
    User.create!( first_name:             firstname,
                  last_name:              lastname,
                  gender_id:              gender,
                  birthdate:              birthdate,
                  username:               username,
                  password:               password,
                  password_confirmation:  password)
  end
  puts "Fake users now add up to #{User.all.count}"
end

def make_addresses
  users = User.all(limit: 100)
  users.each do |user|
    3.times do
      line1 = Faker::Address.street_address
      city = Faker::Address.city
      state = ("1".."51").to_a.sample
      zip = Faker::Address.zip_code
      address_type = ["1","2","3"].sample 
      user.addresses.create!(
        line_1:           line1,
        city:             city,
        state_id:         state,
        zip:              zip,
        address_type_id:  address_type 
        )
      if user.addresses.count == 1 
        user.addresses.toggle!(:primary)
      end
    end
  end
  puts "3 fake addresses added for all fake users"
end

def make_phones
  users = User.all(limit: 100)
  users.each do |user|
    3.times do
      phone = "#{(100..999).to_a.sample}-#{(100..999).to_a.sample}-#{(1000..9999).to_a.sample}"
      phone_type = ["1","2","3"].sample 
      user.phones.create!(
        number:         phone,
        phone_type_id:  phone_type 
        )
    end
  end
  puts "3 fake phones added for all fake users"
end

def make_emails
  users = User.all(limit: 100)
  users.each do |user|
    3.times do
      email = Faker::Internet.email
      email_type = ["1","2"].sample 
      user.emails.create!(
        address:         email,
        email_type_id:   email_type 
        )
    end
  end
  puts "3 fake emails added for all fake users"
end