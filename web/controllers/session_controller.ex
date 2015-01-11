defmodule Isis.SessionController do
  use Isis.Helper.Application
  alias Isis.User
  alias Plug.Conn
  
  plug :action

  def new(conn, _params) do
    if conn.assigns[:current_user] do
      conn
      |> redirect to: Isis.Router.Helpers.page_path(:index)
    else
      render conn, "new.html", %{title: "Log In"}
    end
  end
  
  def create(conn, params) do
    user = User.get(params["email"])
    if User.auth?(user, params["password"]) do
      conn
      |> Conn.fetch_session
      |> Conn.put_session(:email, user.email)
      |> Flash.put(:notice, "Logged in as #{user.email}")
      |> redirect to: Isis.Router.Helpers.page_path(:index)
    else
      conn = Flash.put(conn, :warning, "Please re-enter your password")
      messages = Flash.get(conn)
      render conn, "new.html", %{title: "Log In", flash_messages: messages}
    end
  end
  
  def destroy(conn, _params) do
    conn
    |> Conn.fetch_session
    |> Conn.delete_session(:email)
    |> Flash.put(:notice, "Logged out")
    |> redirect to: Isis.Router.Helpers.page_path(:index)
  end

end