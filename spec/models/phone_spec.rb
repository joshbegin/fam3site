require 'spec_helper'

describe Phone do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    @number = { 
      number: "5555555555",
      phone_type_id: 1 
    }
    @phone = @user.phones.build(@number)
  end

  subject { @phone }

  it { should respond_to(:number) }
  it { should respond_to(:phone_type) }
  it { should respond_to(:primary) }
  it { should respond_to(:user) }
  its(:user) { should == @user }

  it { should be_valid }
  
  it "should reject invalid phone numbers" do
    @phone.number = "alphabet"
    @phone.should_not be_valid
  end
  
   it "should be destroyed if the User is destroyed" do
    @user.destroy
    @user.phones.should be_blank
  end
  
  it "should have the correct associated Type" do
    @phone.phone_type.name.should == "Home"
  end
end
