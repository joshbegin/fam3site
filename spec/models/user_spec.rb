require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :first_name => "Example",
      :middle_name => "A",
      :last_name => "User",
      :username => "testuser",
      :birthdate => "1980-01-01",
      :gender_id => 1,
      :password => "foobar",
      :password_confirmation => "foobar"
    }
    @addr = {
      :line_1 => "123 some st",
      :line_2 => "Suite 2",
      :line_3 => "Line 3",
      :city => "City",
      :state_id => 1,
      :zip => "12345"
    }
    @email = {
      :address => "user@sample.com"
    }
    @phone = {
      :number => "111223333"
    }
    @params = { 
      :user => {
        :name => "Joe", 
        :email => "user@example.com", 
        :password => "foobar", 
        :password_confirmation => "foobar", 
        :birthdate => "1980-01-01",
        :gender_id => 1, 
        :phones_attributes => [
          { :number => "1234567890", :phone_type_id => 1 },
          { :number => "2345678901", :phone_type_id => 2 }
        ]
      } }
  end
  
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
  
  it "should require a username" do
    no_username_user = User.new(@attr.merge(:username => ""))
    no_username_user.should_not be_valid
  end
  
#  it "should accept valid email addresses" do
#    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
#    addresses.each do |address|
#      valid_email_user = User.new(@attr.merge(:email => address))
#      valid_email_user.should be_valid
#    end
#  end
  
#  it "should reject invalid email addresses" do
#    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
#    addresses.each do |address|
#      invalid_email_user = User.new(@attr.merge(:email => address))
#      invalid_email_user.should_not be_valid
#    end
#  end
  
  it "should reject duplicate usernames" do
    User.create!(@attr)
    user_with_duplicate_username = User.new(@attr)
    user_with_duplicate_username.should_not be_valid
  end
  
#  it "should reject email addresses identical up to case" do
#    upcased_email = @attr[:email].upcase
#    User.create!(@attr.merge(:email => upcased_email))
#    user_with_duplicate_email = User.new(@attr)
#    user_with_duplicate_email.should_not be_valid
#  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:first_name => "", :last_name => ""))
    no_name_user.should_not be_valid
  end
  
#  it "should reject duplicate names" do
#    #Put a user with given name into the database.
#    User.create!(@attr)
#    user_with_duplicate_name = User.new(@attr.merge(:username => "anotheruser"))
#    user_with_duplicate_name.should_not be_valid
#  end
  
  it "should require a birthdate" do
    no_birthdate_user = User.new(@attr.merge(:birthdate => ""))
    no_birthdate_user.should_not be_valid
  end
  
  it "should require a gender" do
    no_gender_user = User.new(@attr.merge(:gender_id => ""))
    no_gender_user.should_not be_valid
  end
  
  it "should have the correct associated gender" do
    user = User.create!(@attr)
    user.gender.name.should == "Male"
  end
  
#  it "should create a new address given valid attributes" do
#    user = User.create!(@attr)
#    user.addresses.create!(@addr.merge(:user_id => user.id))
#  end
  
#  it "should allow multiple addresses" do
#    user = User.create!(@attr)
#    user.addresses.create!(@addr.merge(:user_id => user.id))
#    user.addresses.create!(@addr.merge(:user_id => user.id, :line_1 => "second address"))
#  end
  
#  it "should create a new email given valid attributes" do
#    user = User.create!(@attr)
#    user.emails.create!(@email.merge(:user_id => user.id))
#  end

#  it "should allow many emails" do
#    user = User.create!(@attr)
#    user.emails.create!(@email.merge(:user_id => user.id))
#    user.emails.create!(@email.merge(:user_id => user.id, :address => "test@example.com"))
#  end

#  it "should create a new phone number given valid attributes" do
#    user = User.create!(@attr)
#    user.phones.create!(@phone.merge(:user_id => user.id))
#  end
  
#  it "should allow many phones" do
#    user = User.create!(@attr)
#    user.phones.create!(@phone.merge(:user_id => user.id))
#    user.phones.create!(@phone.merge(:user_id => user.id, :number => "2223334444"))
#  end
  
#  it "should create phones through user" do
#    user = User.create!(@params[:user])
#  end
  
#  it "should delete phones when user is deleted" do
#    user = User.create!(@params[:user])
#    user.destroy
#    user.phones.should be_blank
#  end

 describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
  end
  
end