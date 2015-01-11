defmodule Isis.UserController do
  use Isis.Helper.Application
  alias Isis.User
  alias Plug.Conn
  
  plug :action
  
  def new(conn, _params) do
    if conn.assigns[:current_user] do
      conn
      |> redirect to: Isis.Router.Helpers.page_path(:index)
    else
      render conn, "new.html", %{title: "Sign Up", user: %User{}}
    end
  end
  
  def create(conn, params) do
    sanitized_params = sanitize_params(User, params)
    result = User.create(sanitized_params)
    case result do
      { :ok, user } ->
        conn
        |> Conn.fetch_session
        |> Conn.put_session(:email, user.email)
        |> Flash.put(:notice, "User #{user.email} created")
        |> redirect to: Isis.Router.Helpers.page_path(:index)
      { :error, errors } ->
        render conn, "new.html", %{title: "Sign Up", user: sanitized_params, errors: errors}
    end
  end
  
end