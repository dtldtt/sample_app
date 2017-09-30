require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path,params: {user:{name: "",
                              email:"user@invalid",
                              password:"foo",
                              password_confirmation:"bar" }}
    end
    assert_template 'users/new'
    assert_select 'form[action="/signup"]'
    # assert_select 'div#<CSS id for error explanation>'
    # assert_select 'div.<CSS class for field with error>'
  end

  test "vlid signup information" do 
    get signup_path
    assert_difference 'User.count',1 do
      post signup_path,params: {user:{name:"exampleuser",
                                email:"user@example.com",
                                password: "example",
                                password_confirmation: "example" }}
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
    end
  end
end
