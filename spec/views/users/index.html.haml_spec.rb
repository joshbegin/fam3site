require 'spec_helper'

describe "users/index.html.haml" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :first_name => "First Name",
        :middle_name => "Middle Name",
        :last_name => "Last Name",
        :gender_id => 1,
        :username => "Username",
        :password_digest => "Password Digest"
      ),
      stub_model(User,
        :first_name => "First Name",
        :middle_name => "Middle Name",
        :last_name => "Last Name",
        :gender_id => 1,
        :username => "Username",
        :password_digest => "Password Digest"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Middle Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Password Digest".to_s, :count => 2
  end
end
