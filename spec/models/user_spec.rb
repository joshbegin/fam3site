require 'spec_helper'

describe User do
  
  before do
    @user = User.new(first_name: "Example",
                      middle_name: "A",
                      last_name: "User",
                      username: "testuser",
                      birthdate: "1980-01-01",
                      gender_id: 1,
                      password: "foobar",
                      password_confirmation: "foobar")
    @attr = { 
      first_name: "Example",
      middle_name: "A",
      last_name: "User",
      username: "testuser",
      birthdate: "1980-01-01",
      gender_id: 1,
      password: "foobar",
      password_confirmation: "foobar"
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
      :number => "1112223333",
      :phone_type_id => 1
    }
    @params = { 
      :user => {
        :first_name => "Joe", 
        :last_name => "Schmoe",
        :username => "user1", 
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
  
  subject { @user }
 
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:middle_name) }
  it { should respond_to(:username) }
  it { should respond_to(:birthdate) }
  it { should respond_to(:gender_id) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:admin) }

  it { should be_valid }
  
  it "should require a username" do
    @user.username = " "
    @user.should_not be_valid
  end
  
  it "should require a unique username" do
    user_with_same_username = @user.dup
    user_with_same_username.username = @user.username
    user_with_same_username.save

    @user.should_not be_valid
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:first_name => "", :last_name => ""))
    no_name_user.should_not be_valid
  end
  
 # it "should reject duplicate names" do
 #   #Put a user with given name into the database.
 #   User.create!(@attr)
 #   user_with_duplicate_name = User.new(@attr.merge(:username => "anotheruser"))
 #   user_with_duplicate_name.should_not be_valid
 # end
  
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
  
  describe "passwords" do
    
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
end