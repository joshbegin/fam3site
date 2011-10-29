require 'spec_helper'

describe Email do
  
  before(:each) do
    @user = Factory(:user)
    @email = { 
      :address => "user@test.com",
      :email_type_id => 1 
    }
  end
    
  it "should create a new instance given valid attributes" do
    @user.emails.create!(@email.merge(:user_id => @user.id))
  end
  
  it "should reject invalid email address" do
    @user.emails.new(:address => "invalid.address", :user_id => @user.id).should_not be_valid
  end
  
   it "should be destroyed if the User is destroyed" do
    @user.emails.create!(@email.merge(:user_id => @user.id))
    @user.destroy
    @user.emails.should be_blank
  end
  
  it "should have the correct associated Type" do
    @user.emails.create!(@email.merge(:user_id => @user.id))
    @emails = @user.emails.first
    @emails.email_type.name.should == "Personal"
  end
end
