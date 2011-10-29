require 'spec_helper'

describe Address do
  
  before(:each) do
    @user = Factory(:user)
    @addr = {
      :line_1 => "123 some st",
      :line_2 => "Suite 2",
      :line_3 => "Line 3",
      :city => "City",
      :state_id => 1,
      :zip => "12345",
      :address_type_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Address.create!(@addr)
  end
  
  it "should be destroyed if the User is destroyed" do
    @user.addresses.create!(@addr.merge(:user_id => @user.id))
    @user.destroy
    @user.addresses.should be_blank
  end
  
  it "should have the correct associated Type" do
    @user.addresses.create!(@addr.merge(:user_id => @user.id))
    @address = @user.addresses.first
    @address.address_type.name.should == "Home"
  end

  it "should have the correct associated State" do
    @user.addresses.create!(@addr.merge(:user_id => @user.id))
    @address = @user.addresses.first
    @address.state.name.should == "Alabama"
  end

end