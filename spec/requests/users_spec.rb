require 'spec_helper'

describe "Users" do
  describe "GET /home" do
    it "displays home page" do
      visit root_path
      page.should have_content("Home")
    end
  end
  
  describe "User Sign up" do
    it "displays the sign up page" do
      visit root_path
      click_link "Sign up"
#      save_and_open_page
      page.should have_content("New user")
      page.should have_content("Password")
    end
    
    it "creates user" do
      visit root_path
      click_link "Sign up"
      fill_in "First name", :with => "John"
      fill_in "Middle name", :with => "Jacob"
      fill_in "Last name", :with => "Jingleheimer"
      fill_in "Birthdate", :with => '01/01/1980'
      select "Male", :from => 'user_gender_id'
#      fill_in 'user_phones_attributes_0_content', :with => '1234567890'
#      select "Home", :from => 'user_phones_phone_type_id'
      fill_in "Username", :with => 'testuser'
      fill_in "Password", :with => "pass123"
      fill_in "Password confirmation", :with => "pass123"
      click_button "Sign up"
      page.should have_content("successfully created.")
      save_and_open_page
    end
  end
  
end
