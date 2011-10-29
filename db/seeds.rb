# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Gender.count < 2
  puts "Creating genders"
    genders = Gender.create([
      { :name => 'Male' }, 
      { :name => 'Female' }
    ])
end

if AddressType.count < 3
  puts "Creating address types"
    address_types = AddressType.create([
      { :name => 'Home' },
      { :name => 'Vacation' },
      { :name => 'Work' }
    ])
end

states = ['Alabama','Alaska','Arizona','Arkansas','California','Colorado','Connecticut',
          'Delaware','District of Columbia','Florida','Georgia','Hawaii','Idaho','Illinois',
          'Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Maryland','Massachusetts',
          'Michigan','Minnesota','Mississippi','Missouri','Montana','Nebraska','Nevada',
          'New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota',
          'Ohio','Oklahoma','Oregon','Pennsylvania','Rhode Island','South Carolina','South Dakota',
          'Tennessee','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming']

if State.count < 50
  puts "Creating states"
  states.each do |state|
    State.create( :name => state )
  end
end

if EmailType.count < 2
  puts "Creating email types"
  email_types = EmailType.create([
    { :name => 'Personal' },
    { :name => 'Business' }
  ])
end

if PhoneType.count < 3
  puts "Creating phone types"
  phone_types = PhoneType.create([
    { :name => 'Home' },
    { :name => 'Work' },
    { :name => 'Cell' }
  ])
end