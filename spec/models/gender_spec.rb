require 'spec_helper'

describe Gender do
  
  it "should allow Male" do
    Gender.first.name.should == "Male"
  end
  
  it "should allow Female" do
    Gender.last.name.should == "Female"
  end
   
end
