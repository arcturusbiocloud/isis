defmodule Isis.UserManageTest do
  use IsisTest.Case
  use Hound.Helpers

  alias Isis.User
  alias Isis.Endpoint
  
  hound_session

  setup do
    user_params = Factory.User.attributes_for(:user)
    { :ok, user_params: user_params }
  end
  
  test "create a new user and login", ctx do
    navigate_to(user_path(:new) |> Endpoint.url)
    assert page_title() == "Arcturus BioCloud - Sign Up"
    find_element(:name, "email")
    |> fill_field(ctx[:user_params][:email])
    find_element(:name, "emailconfirm")
    |> fill_field(ctx[:user_params][:email])
    find_element(:name, "password")
    |> fill_field(ctx[:user_params][:password])
    find_element(:name, "passwordconfirm")
    |> fill_field(ctx[:user_params][:password])
    find_element(:name, "submit")
    |> click
    assert page_title() == "Arcturus BioCloud - Welcome"
    assert visible_text({:id, "warning-message"}) == "User #{ctx[:user_params][:email]} created"
    element_id = find_element(:link_text, "Logout")
    assert element_displayed?(element_id) == true
  end
  
  test "can't create an user if already logged", ctx do
    { :ok, user } = User.create(ctx[:user_params])
    navigate_to(login_path(:new) |> Endpoint.url)
    assert page_title() == "Arcturus BioCloud - Log In"
    find_element(:name, "email")
    |> fill_field(ctx[:user_params][:email])
    find_element(:name, "password")
    |> fill_field(ctx[:user_params][:password])
    find_element(:name, "submit")
    |> click
    assert page_title() == "Arcturus BioCloud - Welcome"
    navigate_to(user_path(:new) |> Endpoint.url)
    assert page_title() == "Arcturus BioCloud - Welcome"
    element_id = find_element(:link_text, "Logout")
    assert element_displayed?(element_id) == true
  end

end