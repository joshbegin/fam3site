require 'spec_helper'

describe "users/edit.html.haml" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :first_name => "MyString",
      :middle_name => "MyString",
      :last_name => "MyString",
      :gender_id => 1,
      :username => "MyString",
      :password_digest => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_first_name", :name => "user[first_name]"
      assert_select "input#user_middle_name", :name => "user[middle_name]"
      assert_select "input#user_last_name", :name => "user[last_name]"
      assert_select "input#user_gender_id", :name => "user[gender_id]"
      assert_select "input#user_username", :name => "user[username]"
      assert_select "input#user_password_digest", :name => "user[password_digest]"
    end
  end
end
