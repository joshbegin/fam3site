require 'spec_helper'

describe PhoneType do
  it "should have the proper Types" do
    PhoneType.find(1).name.should == "Home"
    PhoneType.find(2).name.should == "Work"
    PhoneType.find(3).name.should == "Cell"
  end
end
