require 'spec_helper'

describe AddressType do
  
  it { should respond_to(:name) }
  
  it "should have the proper Types" do
    AddressType.find(1).name.should == "Home"
    AddressType.find(2).name.should == "Vacation"
    AddressType.find(3).name.should == "Work"
  end
end
