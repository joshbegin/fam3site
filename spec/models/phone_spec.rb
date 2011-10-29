require 'spec_helper'

describe Phone do
  
  before(:each) do
    @user = Factory(:user)
    @phone = { 
      :number => "5555555555",
      :phone_type_id => 1 
    }
  end
    
  it "should create a new instance given valid attributes" do
    @user.phones.create!(@phone.merge(:user_id => @user.id))
  end
  
  it "should reject invalid phone numbers" do
    @user.phones.new(:number => "alphabet", :user_id => @user.id).should_not be_valid
  end
  
   it "should be destroyed if the User is destroyed" do
    @user.phones.create!(@phone.merge(:user_id => @user.id))
    @user.destroy
    @user.phones.should be_blank
  end
  
  it "should have the correct associated Type" do
    @user.phones.create!(@phone.merge(:user_id => @user.id))
    @phones = @user.phones.first
    @phones.phone_type.name.should == "Home"
  end
end
