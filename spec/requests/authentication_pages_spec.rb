require 'spec_helper'

describe "AuthenticationPages" do
  
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',      text: 'Log in') }
    it { should have_selector('title',   text: 'Log in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Log in" }

      it { should have_selector('title',  text: 'Log in') }
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link "Family Site" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }


      describe "and attemtping to visit Users#new page" do
        before { visit new_user_path }
        it { should have_selector('h1', text: 'Users') }
      end

      describe "followed by signout" do
        before { click_link "Log out" }
        it { should have_link('Log in') }
      end

      it { should have_selector('title', text: "Users") }

      it { should have_link('Users',    href: users_path) }
      it { should have_link('My Profile', href: user_path(user)) }
      it { should have_link('Birthdates', href: birthdates_path) }
      it { should have_link('Phones', href: phones_path) }
      it { should have_link('Addresses', href: addresses_path) }
      it { should have_link('Log out', href: signout_path) }
      it { should_not have_link('Log in', href: signin_path) }
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      it { should_not have_link('My Profile', href: user_path(user)) }
      it { should_not have_link('Users', href: users_path) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Username",    with: user.username
          fill_in "Password", with: user.password
          click_button "Log in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit User')
          end
        end
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(users_path) }        
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, username: "wronguser") }
      before do
        visit signin_path
        sign_in user
      end

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(signin_path) }
      end
    end
  end
end
