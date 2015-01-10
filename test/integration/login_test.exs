defmodule Isis.LoginTest do
  use IsisTest.Case
  use Hound.Helpers

  alias Isis.User
  alias Isis.Endpoint
  
  hound_session

  setup do
    user_params = Factory.User.attributes_for(:user)
    { :ok, _user } = User.create(user_params)
    { :ok, user_params: user_params }
  end
  
  test "can login with valid credential", ctx do
    navigate_to(login_path(:new) |> Endpoint.url)
    assert page_title() == "Arcturus BioCloud - Log In"
    find_element(:name, "email")
    |> fill_field(ctx[:user_params][:email])
    find_element(:name, "password")
    |> fill_field(ctx[:user_params][:password])
    find_element(:name, "submit")
    |> click
    assert page_title() == "Arcturus BioCloud - Welcome"
    element_id = find_element(:link_text, "Logout")
    assert element_displayed?(element_id) == true
  end
  
  test "can't login with an invalid credential", ctx do
    navigate_to(login_path(:new) |> Endpoint.url)
    assert page_title() == "Arcturus BioCloud - Log In"
    find_element(:name, "email")
    |> fill_field("foo@gmail.com")
    find_element(:name, "password")
    |> fill_field("123456")
    find_element(:name, "submit")
    |> click
    assert page_title() == "Arcturus BioCloud - Log In"
    assert visible_text({:id, "warning-message"}) == "Please re-enter your password"
  end
  
end
