require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "lauput links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]",root_path, count: 2
    assert_select "a[href=?]",help_path
    assert_select "a[href=?]",about_path
    assert_select "a[href=?]",contact_path
    assert_select "a[href=?]",signup_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "layout links logout" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]",login_path
    get login_path
    assert_select "title", full_title("Log in")
  end

  test "layout lonks log in" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    get user_path(@user)
    assert_select "title", full_title( "#{ @user.name }" )
    get edit_user_path(@user)
    assert_select "title", full_title("Edit user")
    get users_path
    assert_select "title", full_title("All users")
  end
end
