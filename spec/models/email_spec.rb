require 'spec_helper'

describe Email do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    @addr = { 
      address: "user@test.com",
      email_type_id: 1 
    }
    @email = @user.emails.build(@addr)
  end

  subject { @email }

  it { should respond_to(:address) }
  it { should respond_to(:email_type) }
  it { should respond_to(:primary) }
  it { should respond_to(:user) }
  its(:user) { should == @user }

  it { should be_valid }
    
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      @email.address = address
      @email.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      @email.address = address
      @email.should_not be_valid
    end
  end

  it "should reject email addresses identical up to case" do
    upcased_email = Email.create!(@addr)
    upcased_email.address.upcase!
    duplicate_email = Email.create(@addr)
    duplicate_email.should_not be_valid
  end
  
  it "should be destroyed if the User is destroyed" do
    @user.destroy
    @user.emails.should be_blank
  end
  
  it "should have the correct associated Type" do
    @emails = @user.emails.first
    @emails.email_type.name.should == "Personal"
  end
end
