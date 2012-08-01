require 'spec_helper'

describe EmailType do

  it { should respond_to(:name) }
  
  it "should have the proper Types" do
    EmailType.find(1).name.should == "Personal"
    EmailType.find(2).name.should == "Business"
  end
end