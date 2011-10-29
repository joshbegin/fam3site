require 'spec_helper'

describe State do

states = ['Alabama','Alaska','Arizona','Arkansas','California','Colorado','Connecticut',
          'Delaware','District of Columbia','Florida','Georgia','Hawaii','Idaho','Illinois',
          'Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Maryland','Massachusetts',
          'Michigan','Minnesota','Mississippi','Missouri','Montana','Nebraska','Nevada',
          'New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota',
          'Ohio','Oklahoma','Oregon','Pennsylvania','Rhode Island','South Carolina','South Dakota',
          'Tennessee','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming']
        
  it "should have the proper states" do
    1..50.times do |number|
      State.find(number + 1).name.should be_in(states)
    end  
  end
end