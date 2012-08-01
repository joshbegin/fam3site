require 'spec_helper'

describe Address do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    @addr = {  
      line_1: "Line 1",
      line_2: "Line 2",
      line_3: "Line 3",
      city: "City",
      state_id: 1,
      zip: "Zip",
      address_type_id: 1
    }
    @address = @user.addresses.build(@addr)
  end

  subject { @address }

  it { should respond_to(:line_1) }
  it { should respond_to(:line_2) }
  it { should respond_to(:line_3) }
  it { should respond_to(:city) }
  it { should respond_to(:state_id) }
  it { should respond_to(:zip) }
  it { should respond_to(:address_type_id) }
  it { should respond_to(:user) }
  its(:user) { should == @user }

  it { should be_valid }
  
  it "should be destroyed if the User is destroyed" do
    @user.destroy
    @user.addresses.should be_blank
  end
  
  it "should have the correct associated Type" do
    @address.address_type.name.should == "Home"
  end

  it "should have the correct associated State" do
    @address.state.name.should == "Alabama"
  end

end