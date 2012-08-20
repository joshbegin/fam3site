require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "GET /home" do
    it "displays home page" do
      visit root_path
      page.should have_content("Hello, family")
    end
  end
  
  describe "User Sign up" do

    before { visit signup_path }

    describe "with valid information" do
      before do
        fill_in "First name",                         with: "John"
        fill_in "Middle name",                        with: "Jacob"
        fill_in "Last name",                          with: "Jingleheimer"
        select "2011",                                from: 'user_birthdate_1i'
        select "January",                             from: 'user_birthdate_2i'
        select "1",                                   from: 'user_birthdate_3i'
        select "Male",                                from: 'user_gender_id'
        fill_in "user_phones_attributes_0_number",    with: "1234567890"
        select "Home",                                from: 'user_phones_attributes_0_phone_type_id'
        fill_in 'user_addresses_attributes_0_line_1', with: 'Line 1'
        fill_in 'user_addresses_attributes_0_city',   with: 'City'
        select "Alabama",                             from: "user_addresses_attributes_0_state_id"
        fill_in "user_addresses_attributes_0_zip",    with: "12345"
        select "Home",                                from: "user_addresses_attributes_0_address_type_id"
        fill_in "user_emails_attributes_0_address",   with: "nospam@msn.com"
        select "Personal",                            from: "user_emails_attributes_0_email_type_id"
        fill_in "Username",                           with: 'testuser'
        fill_in "Password",                           with: "pass123"
        fill_in "Password confirmation",              with: "pass123"
      end

      it "should create a user" do
        expect { click_button "Create User" }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button "Create User" }
        let(:user) { User.find_by_username('testuser') }

        it { should have_selector('title', text: "User details") }
        it { should have_selector('div.alert.alert-success', text: 'successfully created.') }
        it { should have_link('Log out') }
      end
    end

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create User" }.not_to change(User, :count)
        #save_and_open_page
      end

      describe "after submission" do
        before { click_button "Create User" }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end
    end

    it "should have * on required fields"
  end

end
