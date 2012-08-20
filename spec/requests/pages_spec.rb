require 'spec_helper'

describe "Pages" do
  
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Hello, family!' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end
      it { should have_selector('h1', text: "Users") }
    end
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'About' }
    let(:page_title) { 'About Us' }
    
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)     { 'Contact' }
    let(:page_title)  { 'Contact' }

    it_should_behave_like "all static pages"
  end


  describe "For non-signed in user" do
    let(:user) { FactoryGirl.create(:user) }
    it "should have the right links on the layout" do
      visit root_path
      click_link "About Us"
      page.should have_selector 'title', text: full_title('About Us')
      click_link "Contact"
      page.should have_selector 'title', text: full_title('Contact')
      click_link "Log in"
      page.should have_selector 'title', text: full_title('Log in')
      click_link "Sign up"
      page.should have_selector 'title', text: full_title('Sign up')
    end

    it { should_not have_link(users_path) }
    it { should_not have_link(birthdates_path) }
    it { should_not have_link(phones_path) }
    it { should_not have_link(addresses_path) }
    it { should_not have_link(user_path(user)) }
    it { should_not have_link(signout_path) }

    it "should not allow access to Users page" do
      visit users_path
      page.should have_content "Log in"
    end

    it "should not allow access to Birthdates page" do
      visit birthdates_path
      page.should have_content "Log in"
    end

    it "should not allow access to Phones page" do
      visit phones_path
      page.should have_content "Log in"
    end

    it "should not allow access to Addresses page" do
      visit addresses_path
      page.should have_content "Log in"
    end

    it "should not allow access to User Details page" do
      visit user_path(user)
      page.should have_content "Log in"
    end
  end

  describe "For Signed in user" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit root_path
      sign_in user
    end

    it { should_not have_link(signin_path) }
    it { should_not have_link(signup_path) }


    it "should have the correct links on the layout" do
      click_link "Users"
      page.should have_selector 'title', text: full_title('Users')
      click_link "Birthdates"
      page.should have_selector 'title', text: full_title('Birthdates')
      click_link "Phones"
      page.should have_selector 'title', text: full_title('Phones')
      click_link "Addresses"
      page.should have_selector 'title', text: full_title('Addresses')
      click_link "My Profile"
      page.should have_selector 'title', text: full_title('User details')
      click_link "About Us"
      page.should have_selector 'title', text: full_title('About Us')
      click_link "Contact"
      page.should have_selector 'title', text: full_title('Contact')
      click_link "Log out"
      page.should have_content "Logged out!"
    end
  end
end
